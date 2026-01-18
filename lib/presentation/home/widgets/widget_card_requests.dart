import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../core/extension/gap.dart';
import '../../../core/providers/language_provider/l10n_provider.dart';
import '../../../core/router/router_key.dart';
import '../../../core/unit/app_color.dart';
import '../../../core/unit/app_text_style.dart';
import '../../../core/widget/widget_cache_network_image.dart';
import '../../../core/widget/widget_loading.dart';
import '../../ticktes_details/domain/ticket_enum.dart';
import '../controller/home_controller.dart';
import '../domain/model/home_model.dart';
import 'widget_card_button.dart';

class WidgetCardRequests extends StatelessWidget {
  final Tickets? tickets;
  final bool? isHistory;
  final bool? loading;

  const WidgetCardRequests({super.key, this.isHistory = false, this.tickets, this.loading = false});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (context, homeController, child) {
        // Get company logo from technician info
        final companyLogo = homeController.currentHomeData?.technician?.company?.logo ?? '';
        
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 12),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.grey.shade300)),
          child: ListTile(
            onTap: loading == true ? null : () => context.push('${RouterKey.layout + RouterKey.requestDetails}?id=${tickets?.id}'),
            contentPadding: const EdgeInsets.only(right: 4),
            minVerticalPadding: 8,
            leading:
                loading == true
                    ? const WidgetLoading(width: 50, height: 50, radius: 1000)
                    : ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 85, maxHeight: 105),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            WidgetCachNetworkImage(width: 41, hieght: 41, image: companyLogo, radius: 1000),
                            if (isHistory == false && tickets != null) ...[
                              2.gap,
                              Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  ConstrainedBox(
                                    constraints: const BoxConstraints(maxWidth: 85, maxHeight: 28),
                                    child: WidgetCardButton(
                                      loading: loading,
                                      title:
                                          '${(context.read<LanguageProvider>().lang == 'ar' ? tickets?.ticketTypeAr ?? '' : tickets?.ticketType ?? '').toUpperCase()}  ${TicketDetailsType.emergency.name == tickets?.ticketType ? '🚨' : ''}',
                                    ),
                                  ),
                                  // Status circle at top-right corner
                                  Positioned(
                                    top: -4,
                                    right: -4,
                                    child: Container(
                                      width: 10,
                                      height: 10,
                                      decoration: BoxDecoration(
                                        color: _statusColor(tickets?.status?.toLowerCase() ?? 'pending'),
                                        borderRadius: BorderRadius.circular(100),
                                        border: Border.all(color: Colors.white, width: 1.5),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),
            title:
                loading == true
                    ? const Row(children: [WidgetLoading(width: 150)])
                    : Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                tickets?.ticketTitle ?? tickets?.customer ?? 'N/A',
                                style: AppTextStyle.style11.copyWith(fontWeight: FontWeight.bold),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              if (tickets?.customer != null && tickets?.customer != 'N/A' && tickets?.ticketTitle != null) ...[
                                1.gap,
                                Text(
                                  tickets?.customer ?? '',
                                  style: AppTextStyle.style9.copyWith(color: AppColor.grey),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                              // Main Service - separate row
                              if (tickets?.mainService != null) ...[
                                1.gap,
                                _buildServiceRow(
                                  context,
                                  tickets!.mainService!,
                                ),
                              ],
                              // Sub Service - separate row
                              if (tickets?.subService != null) ...[
                                1.gap,
                                _buildServiceRow(
                                  context,
                                  tickets!.subService!,
                                ),
                              ],
                              // Date and Time
                              1.gap,
                              Text(
                                _formatTicketDateTime(context, tickets?.date, tickets?.time, tickets?.ticketTimeTo),
                                style: AppTextStyle.style9,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
            subtitle: null,
            trailing: const Icon(Icons.arrow_forward_ios, size: 12, color: Colors.grey),
          ),
        );
      },
    );
  }

  Widget _buildServiceRow(BuildContext context, dynamic service) {
    if (service == null) return const SizedBox.shrink();
    
    final lang = context.read<LanguageProvider>().lang ?? 'en';
    // Handle both SubServiceInfo/MainServiceInfo objects and plain objects
    final name = service.name ?? '';
    final nameArabic = service.nameArabic ?? '';
    final serviceName = lang == 'ar' 
        ? (nameArabic.isNotEmpty ? nameArabic : name)
        : (name.isNotEmpty ? name : '');
    final serviceImage = service.image ?? '';
    
    // Don't show row if no name
    if (serviceName.isEmpty) return const SizedBox.shrink();
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Service Icon - size (24x24) - smaller
        if (serviceImage.isNotEmpty) ...[
          WidgetCachNetworkImage(
            width: 24,
            hieght: 24,
            image: serviceImage,
            radius: 4,
          ),
          4.gap,
        ],
        // Service Name (no label, just value) - takes remaining space, single line
        Flexible(
          child: Text(
            serviceName,
            style: AppTextStyle.style8.copyWith(color: AppColor.black, fontWeight: FontWeight.w500).copyWith(fontSize:lang == 'ar' ?14: 10),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  String _formatTicketDateTime(BuildContext context, DateTime? date, String? time, String? timeTo) {
    // Get current language
    final lang = context.read<LanguageProvider>().lang ?? 'en';
    
    // Format date as dd-MMM-yyyy (English abbreviated month) or dd-MMMM-yyyy (Arabic full month)
    final dateFormat = lang == 'ar' 
        ? DateFormat("dd-MMMM-yyyy", "ar")
        : DateFormat("dd-MMM-yyyy", "en_US");
    final dateStr = date != null 
        ? dateFormat.format(date)
        : dateFormat.format(DateTime.now());
    
    // Format time from ticketTimeFrom (e.g., "14:00:00" -> "14:00")
    String timeStr = '';
    if (time != null && time.isNotEmpty) {
      try {
        // ticketTimeFrom is already in "HH:mm:ss" or "HH:mm" format from backend
        final timeParts = time.split(':');
        if (timeParts.length >= 2) {
          // Take only hours and minutes (HH:mm)
          timeStr = '${timeParts[0]}:${timeParts[1]}';
        } else {
          timeStr = time;
        }
      } catch (e) {
        timeStr = time;
      }
    }
    
    // Format timeTo from ticketTimeTo (e.g., "16:00:00" -> "16:00")
    String timeToStr = '';
    if (timeTo != null && timeTo.isNotEmpty) {
      try {
        // ticketTimeTo is already in "HH:mm:ss" or "HH:mm" format from backend
        final timeToParts = timeTo.split(':');
        if (timeToParts.length >= 2) {
          // Take only hours and minutes (HH:mm)
          timeToStr = '${timeToParts[0]}:${timeToParts[1]}';
        } else {
          timeToStr = timeTo;
        }
      } catch (e) {
        timeToStr = timeTo;
      }
    }
    
    // Combine date and time(s) with LTR mark to prevent RTL reversal in Arabic
    // \u200E is the Left-to-Right Mark (LRM) Unicode character
    String result = '\u200E$dateStr';
    if (timeStr.isNotEmpty) {
      result += ' $timeStr';
      if (timeToStr.isNotEmpty) {
        result += ' - $timeToStr';
      }
    }
    
    return result.trim();
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'pending':
        return AppColor.primaryColor600;
      case 'inprogress':
        return AppColor.blue;
      case 'cancelled':
        return AppColor.red;
      case 'completed':
        return AppColor.green;
      default:
        return AppColor.grey;
    }
  }
}
