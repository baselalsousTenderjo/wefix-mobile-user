import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../../core/services/hive_services/box_kes.dart';
import '../../../injection_container.dart';
import 'ticktes_details_screen_b2b.dart';
import 'ticktes_details_screen_b2c.dart';

/// Ticket Details Screen Wrapper - Switches between B2B and B2C versions based on team selection
class TicktesDetailsScreen extends StatelessWidget {
  final String id;
  const TicktesDetailsScreen({super.key, required this.id});

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
        ? TicktesDetailsScreenB2B(id: id) 
        : TicktesDetailsScreenB2C(id: id);
  }
}
