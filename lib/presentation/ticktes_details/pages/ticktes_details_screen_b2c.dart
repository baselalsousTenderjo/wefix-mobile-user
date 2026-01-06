import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/providers/app_text.dart';
import '../../../core/router/router_key.dart';
import '../../../core/unit/app_color.dart';
import '../../../core/unit/app_text_style.dart';
import '../../../core/widget/language_button.dart';
import '../../../injection_container.dart';
import '../controller/ticktes_details_controller.dart';
import '../domain/ticket_enum.dart';
import '../widgets/widget_button_ticket_details.dart';
import 'advantage_tickets.dart';
import 'containers/container_description_section.dart';
import 'containers/container_attachments_section.dart';
import 'containers/container_completion_checklist_section.dart';
import 'containers/container_customer_section.dart';
import 'containers/container_maintenance_section.dart';
import 'containers/container_material_section.dart';
import 'containers/container_provider_attachment.dart';
import 'containers/container_service_provide_section.dart';
import 'containers/container_tools_section.dart';
import 'customer_services.dart';

/// B2C Ticket Details Screen - Shows ticket details for WeFix Team users (original implementation)
class TicktesDetailsScreenB2C extends StatelessWidget {
  final String id;
  const TicktesDetailsScreenB2C({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => sl<TicktesDetailsController>()..ticketDetails(id))],
      child: Consumer<TicktesDetailsController>(
        builder: (context, controller, child) {
          return PopScope(
            canPop: controller.recording != true,
            onPopInvokedWithResult: (didPop, result) {
              if (didPop) {
                context.go('${RouterKey.layout}?index=0');
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Row(
                      spacing: 10,
                      children: [
                        const Icon(Icons.error, color: AppColor.white),
                        Text(AppText(context, isFunction: true).youneedtofinishthisticketfirst, style: AppTextStyle.style14B),
                      ],
                    ),
                    backgroundColor: AppColor.red,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    margin: const EdgeInsets.all(10),
                    duration: const Duration(seconds: 3),
                    elevation: 6,
                  ),
                );
              }
            },
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  '${AppText(context).ticket} #$id ${TicketDetailsType.emergency.name == controller.ticketsDetails?.type ? '🚨' : ''}',
                  style: AppTextStyle.style16B,
                ),
                centerTitle: true,
                actions: const [LanguageButton()],
              ),
              body: SingleChildScrollView(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ContainerMaintenanceSection(),
                    const ContainerCustomerSection(),
                    if (controller.ticketsDetails?.type != TicketDetailsType.preventive.name) const CustomerServices(),
                    if (controller.ticketsDetails?.type != TicketDetailsType.preventive.name) const AdvantageTickets(),
                    const ContainnerDescriptionSection(),
                    const ContainerServiceProvideSection(),
                    const ContainerAttachmentsSection(),
                    if (controller.ticketsDetails?.type != TicketDetailsType.preventive.name) ContainerProviderAttachment(id: id),
                    ContainerToolsSection(id: id),
                    if (controller.ticketsDetails?.type != TicketDetailsType.preventive.name) ContainerMaterialSection(id: id),
                    if (controller.ticketsDetails?.type == TicketDetailsType.preventive.name) ContainerCompletionChecklist(id: id),
                  ],
                ),
              ),
              bottomNavigationBar: const WidgetButtonTicketDetails(),
            ),
          );
        },
      ),
    );
  }
}
