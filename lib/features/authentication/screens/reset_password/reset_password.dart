import 'package:flutter/material.dart';
import 'package:women_safety_dashboard/features/authentication/screens/reset_password/responsive_screens/reset_password_desktop_tablet.dart';
import 'package:women_safety_dashboard/features/authentication/screens/reset_password/responsive_screens/reset_password_mobile.dart';

import '../../../../common/widgets/layouts/templates/site_layout.dart';

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
