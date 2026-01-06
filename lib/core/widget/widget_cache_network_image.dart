import 'package:cached_network_image_plus/flutter_cached_network_image_plus.dart';
import 'package:flutter/material.dart';

import '../constant/app_links.dart';

class WidgetCachNetworkImage extends StatelessWidget {
  final String image;
  final String? title;
  final BoxFit? boxFit;
  final double? radius;
  final double? width;
  final double? hieght;
  final bool? isOutApp;

  const WidgetCachNetworkImage({super.key, required this.image, this.boxFit, this.radius, this.isOutApp = false, this.title, this.width, this.hieght});

  String _getFullImageUrl(String imagePath) {
    if (imagePath.isEmpty) return '';
    
    // If it's already a full URL, return as is
    if (imagePath.startsWith('http://') || imagePath.startsWith('https://')) {
      return imagePath;
    }
    
    // If it's a relative path (starts with /), construct full URL
    if (imagePath.startsWith('/')) {
      // Use team-based server (handles file serving)
      String baseUrl = AppLinks.getServerForTeam();
      // Remove /api/v1 if present
      baseUrl = baseUrl.replaceAll('/api/v1', '');
      baseUrl = baseUrl.endsWith('/') ? baseUrl.substring(0, baseUrl.length - 1) : baseUrl;
      return '$baseUrl$imagePath';
    }
    
    // If it doesn't start with /, assume it's a relative path and prepend /
    String baseUrl = AppLinks.getServerForTeam();
    baseUrl = baseUrl.replaceAll('/api/v1', '');
    baseUrl = baseUrl.endsWith('/') ? baseUrl.substring(0, baseUrl.length - 1) : baseUrl;
    return '$baseUrl/$imagePath';
  }

  @override
  Widget build(BuildContext context) {
    final fullImageUrl = isOutApp == true ? image : _getFullImageUrl(image);
    
    return Container(
      width: width,
      height: hieght,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(radius ?? 0)),
      child: CacheNetworkImagePlus(
        imageUrl: fullImageUrl,
       
        imageBuilder:
            (context, imageProvider) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius ?? 0),
                image: DecorationImage(image: imageProvider, fit: boxFit ?? BoxFit.cover),
              ),
            ),
        errorWidget: const WidgetCachNetworkImage(image: 'https://wefix.oneit.website/favicon.ico', isOutApp: true),
      ),
    );
  }
}
