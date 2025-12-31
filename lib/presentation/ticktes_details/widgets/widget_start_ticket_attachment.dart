import 'dart:async';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';

import '../../../core/extension/gap.dart';
import '../../../core/providers/app_text.dart';
import '../../../core/unit/app_color.dart';
import '../../../core/unit/app_text_style.dart';
import '../../../core/widget/button/app_button.dart';
import '../../../core/widget/language_button.dart';

class WidgetStartTicketAttachment extends StatefulWidget {
  final String ticketId;
  final Function(String filePath, String fileType) onAttachmentSelected;

  const WidgetStartTicketAttachment({
    super.key,
    required this.ticketId,
    required this.onAttachmentSelected,
  });

  @override
  State<WidgetStartTicketAttachment> createState() => _WidgetStartTicketAttachmentState();
}

class _WidgetStartTicketAttachmentState extends State<WidgetStartTicketAttachment> {
  PlatformFile? selectedFile;
  bool isRecording = false;
  final record = AudioRecorder();
  String? audioPath;
  String? imagePath;
  final ImagePicker _imagePicker = ImagePicker();
  String? selectedFilePath;
  String? selectedFileType; // 'file', 'image', 'video', 'audio'
  bool loading = false;

  Timer? _timer;
  int _seconds = 0;

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
    final result = await FilePicker.platform.pickFiles();
    if (result != null && result.files.isNotEmpty) {
      setState(() {
        selectedFile = result.files.first;
        selectedFilePath = result.files.first.path;
        selectedFileType = 'file';
        // Clear other selections
        audioPath = null;
        imagePath = null;
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
                    imagePath = picked.path;
                    selectedFilePath = picked.path;
                    selectedFileType = 'image';
                    // Clear other selections
                    selectedFile = null;
                    audioPath = null;
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
                    imagePath = picked.path;
                    selectedFilePath = picked.path;
                    selectedFileType = 'video';
                    // Clear other selections
                    selectedFile = null;
                    audioPath = null;
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
      audioPath = path;
      selectedFilePath = path;
      selectedFileType = 'audio';
      _seconds = 0;
      // Clear other selections
      selectedFile = null;
      imagePath = null;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
      });
    });
  }

  Future<void> stopRecording() async {
    final path = await record.stop();
    if (path != null) {
      setState(() {
        isRecording = false;
        audioPath = path;
        selectedFilePath = path;
        selectedFileType = 'audio';
      });
      _timer?.cancel();
    }
  }

  void _handleContinue() {
    if (selectedFilePath == null || selectedFileType == null) {
      // Show error - attachment required
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppText(context).required),
          backgroundColor: AppColor.red,
        ),
      );
      return;
    }

    widget.onAttachmentSelected(selectedFilePath!, selectedFileType!);
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
            if (selectedFilePath != null) ...[
              Text(
                AppText(context).attachments,
                style: AppTextStyle.style14B,
              ),
              10.gap,
              _buildAttachmentPreview(),
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

  Widget _buildAttachmentPreview() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.primaryColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          _getAttachmentIcon(),
          12.gap,
          Expanded(
            child: Text(
              selectedFile?.name ?? selectedFilePath!.split('/').last,
              style: AppTextStyle.style12,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.remove_circle, color: AppColor.red),
            onPressed: () {
              setState(() {
                selectedFilePath = null;
                selectedFileType = null;
                selectedFile = null;
                audioPath = null;
                imagePath = null;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _getAttachmentIcon() {
    if (selectedFileType == 'audio') {
      return Icon(Icons.mic, size: 40, color: AppColor.primaryColor);
    } else if (selectedFileType == 'video') {
      return Icon(Icons.videocam, size: 40, color: AppColor.primaryColor);
    } else if (selectedFileType == 'image') {
      return Icon(Icons.image, size: 40, color: AppColor.primaryColor);
    } else {
      return Icon(Icons.attach_file, size: 40, color: AppColor.primaryColor);
    }
  }
}

