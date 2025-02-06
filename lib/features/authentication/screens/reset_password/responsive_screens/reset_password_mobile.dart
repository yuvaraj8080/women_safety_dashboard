import 'package:flutter/material.dart';
import 'package:women_safety_dashboard/utils/constants/sizes.dart';

import '../widgets/reset_password_widget.dart';

class ResetPasswordScreenMobile extends StatelessWidget {
  const ResetPasswordScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child:Padding(padding:EdgeInsets.all(TSizes.defaultSpace24),
          child:ResetPasswordWidget(),
        )
      ),
    );
  }
}
