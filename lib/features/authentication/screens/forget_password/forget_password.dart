import 'package:flutter/material.dart';
import 'package:flutter_admin_web/common/widgets/layouts/templates/site_layout.dart';
import 'package:flutter_admin_web/features/authentication/screens/forget_password/responsive_screens/forget_password_desktop_tablet.dart';
import 'package:flutter_admin_web/features/authentication/screens/forget_password/responsive_screens/forget_password_mobile.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TSiteTemplate(
      useLayout: false,
      desktop:ForgetPasswordScreenDesktopTablet(),
      mobile: ForgetPasswordScreenMobile(),
    );
  }
}
