import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../../../core/services/hive_services/box_kes.dart';
import '../../../../injection_container.dart';
import 'container_home_card_b2b.dart';
import 'container_home_card_b2c.dart';

/// Home Card Wrapper - Switches between B2B and B2C versions based on team selection
class ContainerHomeCard extends StatelessWidget {
  const ContainerHomeCard({super.key});

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
        ? const ContainerHomeCardB2B() 
        : const ContainerHomeCardB2C();
  }
}
