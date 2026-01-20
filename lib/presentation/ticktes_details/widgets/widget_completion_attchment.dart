import 'dart:io';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import '../../../core/constant/app_links.dart';
import '../../../core/unit/app_color.dart';
import '../../../core/unit/app_text_style.dart';

class WidgetCompletionAttchment extends StatelessWidget {
  final String url;
  final Function()? onDelete;

  const WidgetCompletionAttchment({super.key, required this.url, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [BoxShadow(blurRadius: 1, blurStyle: BlurStyle.outer, color: Colors.grey, offset: Offset(.3, 0))],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            spacing: 10,
            children: [
              const Icon(Icons.file_copy, color: Colors.black),
              Expanded(child: Text(url.split('/').last.toString(), maxLines: 1, overflow: TextOverflow.ellipsis, style: AppTextStyle.style14)),
              Row(
                spacing: 5,
                children: [
                  InkWell(
                    onTap: () {
                      _openAttachment(context, url);
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: AppColor.white,
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: const [BoxShadow(blurRadius: 1, blurStyle: BlurStyle.outer, color: Colors.grey, offset: Offset(.3, 0))],
                      ),
                      child: const Icon(Icons.remove_red_eye_outlined, size: 15, color: AppColor.grey),
                    ),
                  ),
                  InkWell(
                    onTap: onDelete,
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: AppColor.white,
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: const [BoxShadow(blurRadius: 1, blurStyle: BlurStyle.outer, color: Colors.grey, offset: Offset(.3, 0))],
                      ),
                      child: const Icon(Icons.delete, size: 15, color: AppColor.red),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _openAttachment(BuildContext context, String url) async {
    try {
      // If URL is relative (starts with /), construct full URL using team-based server
      String fullUrl = url;
      if (url.startsWith('/')) {
        // Get base URL using team-based server (remove /api/v1 if present)
        String baseUrl = AppLinks.getServerForTeam();
        if (baseUrl.contains('/api/v1')) {
          baseUrl = baseUrl.replaceAll('/api/v1', '');
        }
        // Remove trailing slash if present
        baseUrl = baseUrl.replaceAll(RegExp(r'/$'), '');
        fullUrl = '$baseUrl$url';
      } else if (!url.startsWith('http://') && !url.startsWith('https://')) {
        // If it's not a full URL and doesn't start with /, try to construct it
        String baseUrl = AppLinks.getServerForTeam();
        if (baseUrl.contains('/api/v1')) {
          baseUrl = baseUrl.replaceAll('/api/v1', '');
        }
        baseUrl = baseUrl.replaceAll(RegExp(r'/$'), '');
        fullUrl = '$baseUrl/$url';
      }
      
      // Check if it's a local file path (not starting with http/https)
      final isLocalFile = !fullUrl.startsWith('http://') && !fullUrl.startsWith('https://');
      
      if (isLocalFile) {
        // For local files, open directly with system default app
        try {
          final result = await OpenFile.open(fullUrl);
          if (result.type != ResultType.done) {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Could not open file: ${result.message}'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          }
        } catch (e) {
          // Handle MissingPluginException or other errors gracefully
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Could not open file. Please install a file viewer app.'),
                backgroundColor: Colors.red,
              ),
            );
          }
        }
      } else {
        // For remote URLs (http/https), download first then open with native apps
        await _downloadAndOpenFile(context, fullUrl);
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error opening file: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _downloadAndOpenFile(BuildContext context, String url) async {
    try {
      // Show loading indicator
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Row(
              children: [
                SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
                SizedBox(width: 16),
                Text('Downloading file...'),
              ],
            ),
            duration: Duration(seconds: 30),
          ),
        );
      }

      // Download the file
      final response = await http.get(Uri.parse(url));
      
      if (response.statusCode != 200) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to download file: ${response.statusCode}'),
              backgroundColor: Colors.red,
            ),
          );
        }
        return;
      }

      // Get cache directory (properly configured for FileProvider)
      final cacheDir = await getTemporaryDirectory();
      
      // Extract file name from URL
      final uri = Uri.parse(url);
      final pathSegments = uri.pathSegments;
      final fileName = pathSegments.isNotEmpty 
          ? pathSegments.last 
          : 'file_${DateTime.now().millisecondsSinceEpoch}';
      
      // Create temporary file path
      final filePath = '${cacheDir.path}/$fileName';
      final file = File(filePath);
      
      // Write downloaded bytes to file
      await file.writeAsBytes(response.bodyBytes);
      
      // Hide loading indicator
      if (context.mounted) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      }

      // Open the downloaded file with native apps (gallery, PDF reader, video player, etc.)
      try {
        final result = await OpenFile.open(filePath);
        
        if (result.type != ResultType.done) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Could not open file: ${result.message}'),
                backgroundColor: Colors.red,
              ),
            );
          }
        }
      } catch (e) {
        // Handle MissingPluginException or other errors gracefully
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Could not open file. Please install a file viewer app.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error downloading/opening file: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
