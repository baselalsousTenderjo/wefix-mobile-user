import 'package:flutter/material.dart';

import '../../../core/constant/app_links.dart';
import '../../../core/unit/app_color.dart';
import '../../../core/widget/widget_cache_network_image.dart';

class WidhetEditImageProfile extends StatelessWidget {
  final String imageUrl;
  const WidhetEditImageProfile({super.key, required this.imageUrl});

  String _getFullImageUrl(String imagePath) {
    if (imagePath.isEmpty) return '';
    
    // If it's already a full URL, return as is
    if (imagePath.startsWith('http://') || imagePath.startsWith('https://')) {
      return imagePath;
    }
    
    // If it's a relative path (starts with /), construct full URL
    if (imagePath.startsWith('/')) {
      String baseUrl = AppLinks.getServerForTeam();
      baseUrl = baseUrl.replaceAll('/api/v1', '');
      baseUrl = baseUrl.endsWith('/') ? baseUrl.substring(0, baseUrl.length - 1) : baseUrl;
      return '$baseUrl$imagePath';
    }
    
    // If it doesn't start with /, assume it's a relative path
    String baseUrl = AppLinks.getServerForTeam();
    baseUrl = baseUrl.replaceAll('/api/v1', '');
    baseUrl = baseUrl.endsWith('/') ? baseUrl.substring(0, baseUrl.length - 1) : baseUrl;
    return '$baseUrl/$imagePath';
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Container(
            width: 120,
            height: 120,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), border: Border.all(color: AppColor.grey)),
            child: CircleAvatar(radius: 50, backgroundColor: Colors.white, child: WidgetCachNetworkImage(image: _getFullImageUrl(imageUrl))),
          ),
        ],
      ),
    );
  }
}
