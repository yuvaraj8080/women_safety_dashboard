import 'package:flutter/cupertino.dart';

import '../../../utils/constants/sizes.dart';

class TResponsiveWidget extends StatelessWidget {
  const TResponsiveWidget({super.key, required this.desktop, required this.tablet, required this.mobile});

  ///   WIDGET FOR DESKTOP LAYOUT
  final Widget desktop;

  ///  WIDGET FOR TABLE LAYOUT
  final Widget tablet;

  ///M WIDGET FOR MOBILE LAYOUT
  final Widget mobile;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder:(_,constraints){
        if(constraints.maxWidth >= TSizes.desktopScreenSize){
          return desktop;
        }
        else if(constraints.maxWidth < TSizes.desktopScreenSize && constraints.maxWidth >= TSizes.tabletScreenSize){
           return tablet;
        }
        else{
          return mobile;
        }
      },
    );
  }
}
