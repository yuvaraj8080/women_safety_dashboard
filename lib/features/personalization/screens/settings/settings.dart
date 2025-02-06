import 'package:flutter/material.dart';
import 'package:flutter_admin_web/common/widgets/layouts/templates/site_layout.dart';

import 'responsive_screens/settings_desktop.dart';
import 'responsive_screens/settings_mobile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TSiteTemplate(
      desktop:SettingsDesktopScreen(),
      tablet: SettingsMobileScreen(),
      mobile: SettingsMobileScreen(),
    );
  }
}
