import 'package:flutter/material.dart';
import 'package:flutter_admin_web/common/widgets/layouts/templates/site_layout.dart';

import 'responsive_screens/profile_desktop.dart';
import 'responsive_screens/profile_mobile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
   return const TSiteTemplate(
     desktop:ProfileDesktopScreen(),
     tablet:ProfileMobileScreen(),
     mobile:ProfileMobileScreen()
   );
  }
}
