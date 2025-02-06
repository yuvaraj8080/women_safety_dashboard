import 'package:flutter/material.dart';
import 'package:women_safety_dashboard/features/authentication/screens/login/responsive_screens/login_mobile.dart';

import '../../../../common/widgets/layouts/templates/site_layout.dart';
import 'responsive_screens/login_desktop_tablet.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TSiteTemplate(
      useLayout:false,
      desktop:LoginScreenDesktopTablet(),
      mobile: LoginScreenMobile(),
    );
  }
}
