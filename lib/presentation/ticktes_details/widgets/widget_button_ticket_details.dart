import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../../core/services/hive_services/box_kes.dart';
import '../../../injection_container.dart';
import 'widget_button_ticket_details_b2b.dart';
import 'widget_button_ticket_details_b2c.dart';

/// Ticket Details Button Wrapper - Switches between B2B and B2C versions based on team selection
class WidgetButtonTicketDetails extends StatelessWidget {
  const WidgetButtonTicketDetails({super.key});

  bool _isB2BTeam() {
    try {
      final userTeam = sl<Box>(instanceName: BoxKeys.appBox).get(BoxKeys.userTeam);
      return userTeam == 'B2B Team';
    } catch (e) {
      return false; // Default to B2C if error
    }
  }

  @override
  Widget build(BuildContext context) {
    // Switch between B2B and B2C versions based on team
    return _isB2BTeam() 
        ? const WidgetButtonTicketDetailsB2B() 
        : const WidgetButtonTicketDetailsB2C();
  }
}
