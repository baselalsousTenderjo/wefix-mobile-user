import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:provider/provider.dart';

import '../../../../core/extension/gap.dart';
import '../../../../core/providers/app_text.dart';
import '../../../../core/providers/language_provider/l10n_provider.dart';
import '../../../../core/unit/app_color.dart';
import '../../../../core/unit/app_text_style.dart';
import '../../controller/ticktes_details_controller.dart';
import '../../domain/ticket_enum.dart';
import '../../widgets/widget_record_mainten_scestion.dart';

class ContainerMaintenanceSection extends StatelessWidget {
  const ContainerMaintenanceSection({super.key});

  @override
  Widget build(BuildContext context) {
    String lang = context.read<LanguageProvider>().lang ?? 'en';
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(color: Colors.grey.withOpacity(.4), thickness: 1, height: 20),
        Text('🔧 ${AppText(context).maintenanceTicketDetails}', style: AppTextStyle.style14B),
        10.gap,
        Consumer<TicktesDetailsController>(
          builder: (context, controller, child) {
            return ValueListenableBuilder(
              valueListenable: controller.ticketStatue,
              builder:
                  (context, value, child) => Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      WidgetRecordMaintenSection(
                        title: AppText(context).title,
                        loading: value == TicketStatus.loading,
                        value:
                            controller.ticketsDetails?.type == TicketDetailsType.preventive.name
                                ? lang == 'ar'
                                    ? controller.ticketsDetails?.typeAr ?? ''
                                    : controller.ticketsDetails?.type ?? ''
                                : lang == 'ar'
                                ? controller.ticketsDetails?.titleAr ?? ''
                                : controller.ticketsDetails?.title ?? '',
                        title2: AppText(context).status,
                        value2Widget: _buildStatusChip(
                          context,
                          controller.ticketsDetails?.status ?? '',
                        ),
                      ),
                      20.gap,
                      WidgetRecordMaintenSection(
                        title: AppText(context).type,
                        value:
                            '${lang == 'ar' ? controller.ticketsDetails?.typeAr ?? '' : controller.ticketsDetails?.type ?? ''}  ${TicketDetailsType.emergency.name == controller.ticketsDetails?.type ? '🚨' : ''}',
                        loading: value == TicketStatus.loading,
                        title2: AppText(context).date,
                        value2: _formatCreationDate(controller.ticketsDetails?.date),
                      ),
                      20.gap,
                      WidgetRecordMaintenSection(
                        title: _getTicketCodeLabel(lang),
                        value: _formatTicketCode(controller.ticketsDetails?.ticketCodeId),
                        loading: value == TicketStatus.loading,
                        title2: _getTicketTimeLabel(lang),
                        value2: _formatTicketTimeRange(controller.ticketsDetails?.time, controller.ticketsDetails?.timeTo),
                      ),
                      20.gap,
                    ],
                  ),
            );
          },
        ),
      ],
    );
  }

  String _getTicketCodeLabel(String lang) {
    return lang == 'ar' ? 'رمز التذكرة' : 'Ticket Code';
  }

  String _getTicketTimeLabel(String lang) {
    return lang == 'ar' ? 'وقت التذكرة' : 'Ticket Time';
  }

  String _formatCreationDate(DateTime? date) {
    if (date == null) return '';
    return DateFormat("yyyy-MM-dd").format(date);
  }

  String _formatTicketTimeRange(String? timeFrom, String? timeTo) {
    String formattedFrom = '';
    String formattedTo = '';
    
    if (timeFrom != null && timeFrom.isNotEmpty) {
      try {
        final timeParts = timeFrom.split(':');
        if (timeParts.length >= 2) {
          formattedFrom = '${timeParts[0].padLeft(2, '0')}:${timeParts[1].padLeft(2, '0')}';
        } else {
          formattedFrom = timeFrom;
        }
      } catch (e) {
        formattedFrom = timeFrom;
      }
    }
    
    if (timeTo != null && timeTo.isNotEmpty) {
      try {
        final timeParts = timeTo.split(':');
        if (timeParts.length >= 2) {
          formattedTo = '${timeParts[0].padLeft(2, '0')}:${timeParts[1].padLeft(2, '0')}';
        } else {
          formattedTo = timeTo;
        }
      } catch (e) {
        formattedTo = timeTo;
      }
    }
    
    if (formattedFrom.isNotEmpty && formattedTo.isNotEmpty) {
      return '$formattedFrom - $formattedTo';
    } else if (formattedFrom.isNotEmpty) {
      return formattedFrom;
    } else if (formattedTo.isNotEmpty) {
      return formattedTo;
    }
    return '';
  }

  String _formatTicketCode(String? ticketCodeId) {
    if (ticketCodeId == null || ticketCodeId.isEmpty) return '';
    // Remove "TECH-" prefix and keep what comes after it
    if (ticketCodeId.startsWith('TECH-')) {
      return ticketCodeId.substring(5); // Remove "TECH-" (5 characters)
    }
    return ticketCodeId;
  }


  Color _getStatusColor(String status) {
    final normalizedStatus = status.toLowerCase().replaceAll(' ', '');
    switch (normalizedStatus) {
      case 'pending':
        return AppColor.primaryColor600;
      case 'inprogress':
      case 'in_progress':
        return AppColor.blue;
      case 'cancelled':
      case 'canceled':
        return AppColor.red;
      case 'completed':
        return AppColor.green;
      default:
        return AppColor.grey;
    }
  }

  Widget _buildStatusChip(BuildContext context, String status) {
    final statusColor = _getStatusColor(status);
    final appText = AppText(context);
    
    // Map backend status values to translation keys and get localized text
    final normalizedStatus = status.toLowerCase().replaceAll(' ', '');
    String displayStatus;
    
    switch (normalizedStatus) {
      case 'completed':
        displayStatus = appText.completed;
        break;
      case 'pending':
        displayStatus = appText.pending;
        break;
      case 'inprogress':
      case 'in_progress':
        displayStatus = appText.inProgress;
        break;
      case 'cancelled':
      case 'canceled':
        displayStatus = appText.cancelled;
        break;
      default:
        displayStatus = status.isNotEmpty ? status : 'N/A';
    }
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(.2),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        displayStatus.isEmpty ? status : displayStatus,
        style: AppTextStyle.style10.copyWith(
          color: statusColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
