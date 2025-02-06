import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_web/features/authentication/screens/forget_password/widgets/header_form.dart';
import 'package:flutter_admin_web/utils/constants/sizes.dart';

class ForgetPasswordScreenMobile extends StatelessWidget {
  const ForgetPasswordScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child:Padding(
          padding:EdgeInsets.all(TSizes.defaultSpace24),
            child: HeaderAndForm())
      ),
    );
  }
}
