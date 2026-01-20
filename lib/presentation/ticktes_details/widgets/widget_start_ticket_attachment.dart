import 'dart:async';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../../../core/extension/gap.dart';
import '../../../core/providers/app_text.dart';
import '../../../core/unit/app_color.dart';
import '../../../core/unit/app_text_style.dart';
import '../../../core/widget/button/app_button.dart';
import '../../../core/widget/language_button.dart';
import '../../../core/widget/widget_daialog.dart';

class AttachmentItem {
  final String filePath;
  final String fileType; // 'file', 'image', 'video', 'audio'
  final String? fileName;
  final int? duration; // For audio files

  AttachmentItem({
    required this.filePath,
    required this.fileType,
    this.fileName,
    this.duration,
  });
}

class WidgetStartTicketAttachment extends StatefulWidget {
  final String ticketId;
  final Future<void> Function(String filePath, String fileType, bool isFirstFile) onAttachmentSelected;
  final Future<void> Function()? onStartWithoutAttachment;

  const WidgetStartTicketAttachment({
    super.key,
    required this.ticketId,
    required this.onAttachmentSelected,
    this.onStartWithoutAttachment,
  });

  @override
  State<WidgetStartTicketAttachment> createState() => _WidgetStartTicketAttachmentState();
}

class _WidgetStartTicketAttachmentState extends State<WidgetStartTicketAttachment> {
  final List<AttachmentItem> attachments = [];
  bool isRecording = false;
  final record = AudioRecorder();
  final ImagePicker _imagePicker = ImagePicker();
  bool loading = false;

  Timer? _timer;
  int _seconds = 0;
  String? _currentRecordingPath;

  @override
  void initState() {
    super.initState();
    _requestPermissionsOnce();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _requestPermissionsOnce() async {
    await [
      Permission.microphone,
      Permission.storage,
      Permission.camera,
    ].request();
  }

  Future<void> pickFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result != null && result.files.isNotEmpty) {
      setState(() {
        for (var file in result.files) {
          if (file.path != null) {
            attachments.add(AttachmentItem(
              filePath: file.path!,
              fileType: 'file',
              fileName: file.name,
            ));
          }
        }
      });
    }
  }

  Future<void> pickFromCamera() async {
    final status = await Permission.camera.request();
    if (!status.isGranted) return;

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_camera),
              title: Text(AppText(context).uploadFromCamera),
              onTap: () async {
                final picked = await _imagePicker.pickImage(source: ImageSource.camera);
                if (picked != null) {
                  setState(() {
                    attachments.add(AttachmentItem(
                      filePath: picked.path,
                      fileType: 'image',
                      fileName: picked.path.split('/').last,
                    ));
                  });
                }
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.videocam),
              title: Text(AppText(context).recordVoice),
              onTap: () async {
                final picked = await _imagePicker.pickVideo(source: ImageSource.camera);
                if (picked != null) {
                  setState(() {
                    attachments.add(AttachmentItem(
                      filePath: picked.path,
                      fileType: 'video',
                      fileName: picked.path.split('/').last,
                    ));
                  });
                }
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> startRecording() async {
    final micStatus = await Permission.microphone.status;
    final storageStatus = await Permission.storage.status;

    if (!micStatus.isGranted || !storageStatus.isGranted) {
      await _requestPermissionsOnce();
    }

    final dir = await getApplicationDocumentsDirectory();
    final path = "${dir.path}/audio_${DateTime.now().millisecondsSinceEpoch}.m4a";

    await record.start(const RecordConfig(), path: path);
    setState(() {
      isRecording = true;
      _currentRecordingPath = path;
      _seconds = 0;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
      });
    });
  }

  Future<void> stopRecording() async {
    final path = await record.stop();
    if (path != null && _currentRecordingPath != null) {
      setState(() {
        isRecording = false;
        attachments.add(AttachmentItem(
          filePath: path,
          fileType: 'audio',
          fileName: path.split('/').last,
          duration: _seconds,
        ));
        _currentRecordingPath = null;
        _seconds = 0;
      });
      _timer?.cancel();
    }
  }

  Future<void> _handleContinue() async {
    setState(() {
      loading = true;
    });

    try {
      if (attachments.isEmpty) {
        // Start ticket without attachments (optional)
        if (widget.onStartWithoutAttachment != null) {
          await widget.onStartWithoutAttachment!();
        }
        // Close the screen
        if (mounted) {
          Navigator.pop(context);
        }
        return;
      }

      // Send all attachments one by one sequentially
      // Only the first file should start the ticket
      for (int i = 0; i < attachments.length; i++) {
        final attachment = attachments[i];
        final isFirstFile = i == 0; // Only first file starts the ticket
        await widget.onAttachmentSelected(attachment.filePath, attachment.fileType, isFirstFile);
      }
      // Close the screen after all files are uploaded
      if (mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      // Handle error with proper dialog
      if (mounted) {
        setState(() {
          loading = false;
        });
        String errorMessage;
        // Check for specific error types for better user messages
        if (e.toString().contains('DioException') || e.toString().contains('SocketException')) {
          errorMessage = AppText(context).serviceUnavailable;
        } else if (e.toString().contains('TimeoutException')) {
          errorMessage = AppText(context).serviceUnavailable;
        } else if (e.toString().contains('fileNotFound') || e.toString().contains('File not found')) {
          errorMessage = AppText(context).fileNotFound;
        } else {
          // Use the error message if it's clear, otherwise show generic error
          errorMessage = e.toString().isNotEmpty && !e.toString().contains('Exception:')
              ? e.toString()
              : AppText(context).anErrorOccurred;
        }
        SmartDialog.show(
          builder: (context) => WidgetDilog(
            isError: true,
            title: AppText(context).warning,
            message: errorMessage,
            cancelText: AppText(context).back,
            onCancel: () => SmartDialog.dismiss(),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppText(context).attachments),
        actions: const [LanguageButton()],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppText(context).loading,
              style: AppTextStyle.style14.copyWith(color: AppColor.grey),
            ),
            20.gap,
            _optionTile(
              icon: Icons.attach_file,
              label: AppText(context).uploadFromGallery,
              color: Colors.blue,
              onTap: pickFile,
            ),
            16.gap,
            _optionTile(
              icon: Icons.camera_alt,
              label: AppText(context).uploadFromCamera,
              color: Colors.orange,
              onTap: pickFromCamera,
            ),
            16.gap,
            _optionTile(
              icon: isRecording ? Icons.stop : Icons.mic,
              label: isRecording
                  ? "${AppText(context).recorfing} (${_seconds}s)"
                  : AppText(context).recordVoice,
              color: isRecording ? Colors.red : Colors.green,
              onTap: isRecording ? stopRecording : startRecording,
            ),
            20.gap,
            if (attachments.isNotEmpty) ...[
              Text(
                AppText(context).attachments,
                style: AppTextStyle.style14B,
              ),
              10.gap,
              ...attachments.asMap().entries.map((entry) {
                final index = entry.key;
                final attachment = entry.value;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: _buildAttachmentPreview(attachment, index),
                );
              }).toList(),
            ],
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: AppButton.text(
            text: AppText(context).next,
            loading: loading,
            onPressed: _handleContinue,
          ),
        ),
      ),
    );
  }

  Widget _optionTile({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: color.withOpacity(0.3)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: color),
            16.gap,
            Expanded(
              child: Text(
                label,
                style: AppTextStyle.style14,
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded, size: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildAttachmentPreview(AttachmentItem attachment, int index) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.primaryColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          _getAttachmentIcon(attachment.fileType),
          12.gap,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  attachment.fileName ?? attachment.filePath.split('/').last,
                  style: AppTextStyle.style12,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (attachment.fileType == 'audio' && attachment.duration != null)
                  Text(
                    '${attachment.duration}s',
                    style: AppTextStyle.style10.copyWith(color: AppColor.grey),
                  ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.remove_circle, color: AppColor.red),
            onPressed: () {
              setState(() {
                attachments.removeAt(index);
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _getAttachmentIcon(String fileType) {
    if (fileType == 'audio') {
      return Icon(Icons.mic, size: 40, color: AppColor.primaryColor);
    } else if (fileType == 'video') {
      return Icon(Icons.videocam, size: 40, color: AppColor.primaryColor);
    } else if (fileType == 'image') {
      return Icon(Icons.image, size: 40, color: AppColor.primaryColor);
    } else {
      return Icon(Icons.attach_file, size: 40, color: AppColor.primaryColor);
    }
  }
}

