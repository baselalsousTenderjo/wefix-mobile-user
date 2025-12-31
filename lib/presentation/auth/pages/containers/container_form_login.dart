import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/widget/widget_phone_field.dart';
import '../../controller/auth_provider.dart';

class ContainerFormLogin extends StatelessWidget {
  const ContainerFormLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<AuthProvider>().key,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WidgetPhoneField(onCountryChanged: context.read<AuthProvider>().enterPhoneNumber),
        ],
      ),
    );
  }
}
