import 'package:flutter/material.dart';
import 'package:flutter_admin_web/features/authentication/screens/reset_password/widgets/reset_password_widget.dart';
import 'package:flutter_admin_web/utils/constants/sizes.dart';

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
