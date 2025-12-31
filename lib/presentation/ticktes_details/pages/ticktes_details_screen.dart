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
import 'containers/container_description_section.dart';
import 'containers/container_completion_checklist_section.dart';
import 'containers/container_customer_section.dart';
import 'containers/container_maintenance_section.dart';
// import 'containers/container_material_section.dart'; // Hidden: Required material section
import 'containers/container_service_provide_section.dart';
import 'containers/container_tools_section.dart';
import 'containers/container_completed_ticket_info.dart';
import 'customer_services.dart';

class TicktesDetailsScreen extends StatelessWidget {
  final String id;
  const TicktesDetailsScreen({super.key, required this.id});

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
                  '${AppText(context).ticket} ${controller.ticketsDetails?.ticketCodeId ?? "#$id"} ${TicketDetailsType.emergency.name == controller.ticketsDetails?.type ? '🚨' : ''}',
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
                    const ContainnerDescriptionSection(),
                    const ContainerServiceProvideSection(),
                    ContainerToolsSection(id: id),
                    // Hidden: Required material section
                    // if (controller.ticketsDetails?.type != TicketDetailsType.preventive.name) ContainerMaterialSection(id: id),
                    if (controller.ticketsDetails?.type == TicketDetailsType.preventive.name) ContainerCompletionChecklist(id: id),
                    // Attachment sections (shows both ticket and technician attachments for all tickets)
                    const ContainerCompletedTicketInfo(),
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
