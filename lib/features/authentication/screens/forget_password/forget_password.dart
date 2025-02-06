
import 'package:flutter/material.dart';
import 'package:women_safety_dashboard/features/authentication/screens/forget_password/responsive_screens/forget_password_desktop_tablet.dart';
import 'package:women_safety_dashboard/features/authentication/screens/forget_password/responsive_screens/forget_password_mobile.dart';

import '../../../../common/widgets/layouts/templates/site_layout.dart';

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
