import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/extension/gap.dart';
import '../../../../core/providers/language_provider/l10n_provider.dart';
import '../../../../core/unit/app_color.dart';
import '../../../../core/unit/app_text_style.dart';
import '../../../../core/widget/widget_cache_network_image.dart';
import '../../controller/ticktes_details_controller.dart';
import '../../domain/ticket_enum.dart';

class ContainerCompanySection extends StatelessWidget {
  const ContainerCompanySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        String lang = languageProvider.lang ?? 'en';
        return Consumer<TicktesDetailsController>(
          builder: (context, controller, child) {
        return ValueListenableBuilder(
          valueListenable: controller.ticketStatue,
          builder: (context, value, child) {
            final ticketsDetails = controller.ticketsDetails;
            final company = ticketsDetails?.company;
            final branch = ticketsDetails?.branch;
            final zone = ticketsDetails?.zone;
            
            // Check if we have company/branch/zone data
            final hasCompanyData = company != null || branch != null || zone != null;
            
            if (value == TicketStatus.loading) {
              return const SizedBox.shrink();
            }
            
            // If no company data available, hide section
            if (!hasCompanyData) {
              return const SizedBox.shrink();
            }
            
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(color: AppColor.grey.withOpacity(.4), thickness: 1, height: 20),
                Text(
                  '🏢 ${lang == "ar" ? "معلومات الشركة" : "Company Information"}',
                  style: AppTextStyle.style14B,
                ),
                10.gap,
                // Company Name with Logo
                if (company != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            '${lang == "ar" ? "اسم الشركة" : "Company Name"}:',
                            style: AppTextStyle.style10.copyWith(
                              color: AppColor.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Row(
                            children: [
                              // Company Logo
                              if (company['logo'] != null && 
                                  company['logo'].toString().isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(right: 12),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: WidgetCachNetworkImage(
                                      width: 40,
                                      hieght: 40,
                                      image: company['logo'].toString(),
                                      radius: 8,
                                      boxFit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              // Company Name
                              Expanded(
                                child: Text(
                                  _getCompanyName(company, lang),
                                  style: AppTextStyle.style10.copyWith(
                                    color: AppColor.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                // Branch
                if (branch != null)
                  _buildBranchRow(
                    context,
                    '${lang == "ar" ? "الفرع" : "Branch"}:',
                    _getBranchName(branch, lang),
                    branch['location']?.toString(),
                  ),
                // Zone
                if (zone != null)
                  _buildInfoRow(
                    '${lang == "ar" ? "المنطقة" : "Zone"}:',
                    zone['title']?.toString() ?? '',
                  ),
                20.gap,
              ],
            );
          },
        );
      },
      );
    },
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: AppTextStyle.style10.copyWith(
                color: AppColor.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: AppTextStyle.style10.copyWith(
                color: AppColor.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBranchRow(BuildContext context, String label, String value, String? locationUrl) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: AppTextStyle.style10.copyWith(
                color: AppColor.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    value,
                    style: AppTextStyle.style10.copyWith(
                      color: AppColor.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                if (locationUrl != null && locationUrl.isNotEmpty)
                  InkWell(
                    onTap: () => _openBranchMap(locationUrl),
                    child: Icon(
                      Icons.map,
                      color: AppColor.primaryColor,
                      size: 20,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _openBranchMap(String locationUrl) async {
    try {
      if (locationUrl.isEmpty) {
        return;
      }

      final uri = Uri.parse(locationUrl);
      
      // Try to open in Google Maps app first (for Android/iOS)
      // Extract coordinates from URL if it's a Google Maps URL
      if (locationUrl.contains('google.com/maps')) {
        // Try to extract coordinates from the URL
        final match = RegExp(r'q=([\d.]+),([\d.]+)').firstMatch(locationUrl);
        if (match != null) {
          final lat = match.group(1);
          final lng = match.group(2);
          
          // Try Google Maps app scheme first (Android/iOS)
          final googleMapsUri = Uri.parse('google.navigation:q=$lat,$lng');
          if (await canLaunchUrl(googleMapsUri)) {
            await launchUrl(googleMapsUri, mode: LaunchMode.externalNonBrowserApplication);
            return;
          }
        }
      }
      
      // Fallback: open in browser
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      // Handle error silently
    }
  }

  String _getCompanyName(dynamic company, String currentLang) {
    if (company == null) return '';
    
    final companyMap = company is Map ? company : {};
    final title = companyMap['title']?.toString() ?? '';
    final nameArabic = companyMap['nameArabic']?.toString() ?? '';
    final nameEnglish = companyMap['nameEnglish']?.toString() ?? '';
    
    // Return the appropriate name based on current language
    if (currentLang == "ar") {
      // For Arabic, prefer nameArabic, fallback to title
      return nameArabic.isNotEmpty ? nameArabic : title;
    } else {
      // For English, prefer nameEnglish, fallback to title
      return nameEnglish.isNotEmpty ? nameEnglish : title;
    }
  }

  String _getBranchName(dynamic branch, String currentLang) {
    if (branch == null) return '';
    
    final branchMap = branch is Map ? branch : {};
    final title = branchMap['title']?.toString() ?? ''; // Default branch title
    final nameArabic = branchMap['nameArabic']?.toString() ?? ''; // Arabic name from backend
    final nameEnglish = branchMap['nameEnglish']?.toString() ?? ''; // English name from backend
    
    // Return the appropriate name based on current language
    if (currentLang == "ar") {
      // For Arabic, prefer nameArabic, fallback to title
      return nameArabic.isNotEmpty ? nameArabic : title;
    } else {
      // For English, prefer nameEnglish, fallback to title
      return nameEnglish.isNotEmpty ? nameEnglish : title;
    }
  }
}
