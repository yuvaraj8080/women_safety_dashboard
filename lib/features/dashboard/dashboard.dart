import 'package:flutter/material.dart';
import 'package:women_safety_dashboard/features/dashboard/responsive_screen/dashboard_mobile.dart';
import '../../common/widgets/layouts/templates/site_layout.dart';
import 'responsive_screen/dashboard_desktop.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TSiteTemplate(
      desktop: DashboardDesktopScreen(),
      mobile: DashboardMobileScreen(),
      tablet: DashboardMobileScreen(),
    );
  }
}
