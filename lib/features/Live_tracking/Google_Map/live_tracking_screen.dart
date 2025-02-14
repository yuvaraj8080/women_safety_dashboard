import 'package:flutter/material.dart';
import 'package:women_safety_dashboard/common/widgets/layouts/templates/site_layout.dart';
import 'package:women_safety_dashboard/features/Live_tracking/Google_Map/screens/GoogleMap_View.dart';
import 'package:women_safety_dashboard/features/dashboard/responsive_screen/dashboard_mobile.dart';


class LiveTrackingScreen extends StatelessWidget {
  const LiveTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TSiteTemplate(
      desktop: GoogleMap_View_Screen(),
     
    );
  }
}
