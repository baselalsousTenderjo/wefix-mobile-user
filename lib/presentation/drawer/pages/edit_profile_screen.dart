import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../../core/services/hive_services/box_kes.dart';
import '../../../injection_container.dart';
import 'edit_profile_screen_b2b.dart';
import 'edit_profile_screen_b2c.dart';

/// Edit Profile Screen Wrapper - Switches between B2B and B2C versions based on team selection
class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

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
        ? EditProfileScreenB2B() 
        : EditProfileScreenB2C();
  }
}
