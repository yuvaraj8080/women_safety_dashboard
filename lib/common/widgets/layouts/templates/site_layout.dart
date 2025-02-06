import 'package:flutter/material.dart';

import '../../responsive/responsive_disign.dart';
import '../../responsive/screens/desktop_layout.dart';
import '../../responsive/screens/mobile_layout.dart';
import '../../responsive/screens/tablet_layout.dart';

class TSiteTemplate extends StatelessWidget {
  const TSiteTemplate({super.key,  this.desktop,  this.tablet,  this.mobile,this.useLayout = true});

  ///   WIDGET FOR DESKTOP LAYOUT
  final Widget? desktop;

  ///  WIDGET FOR TABLE LAYOUT
  final Widget? tablet;

  ///M WIDGET FOR MOBILE LAYOUT
  final Widget? mobile;

  /// FLAG TO DETERMINE WHETHER TO USE THE LAYOUT
  final bool useLayout;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:TResponsiveWidget(
        desktop:useLayout ? DesktopLayout(body:desktop) : desktop ?? Container(),
        tablet:useLayout ? TabletLayout(body:tablet) : tablet ?? desktop ?? Container(),
        mobile:useLayout ? MobileLayout(body:mobile) : mobile ?? desktop ?? Container(),
      )
    );
  }
}
