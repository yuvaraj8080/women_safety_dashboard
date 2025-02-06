import 'package:flutter/material.dart';
import 'package:flutter_admin_web/common/widgets/layouts/templates/site_layout.dart';
import 'package:flutter_admin_web/features/authentication/screens/reset_password/responsive_screens/reset_password_desktop_tablet.dart';
import 'package:flutter_admin_web/features/authentication/screens/reset_password/responsive_screens/reset_password_mobile.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TSiteTemplate(
      useLayout:false,
      desktop:ResetPasswordScreenDesktopTablet(),
      mobile:ResetPasswordScreenMobile(),
    );
  }
}
