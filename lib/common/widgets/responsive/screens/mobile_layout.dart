import 'package:flutter/material.dart';
import 'package:flutter_admin_web/common/widgets/layouts/headers/header.dart';
import 'package:flutter_admin_web/common/widgets/layouts/sidebars/sidebar.dart';


class MobileLayout extends StatelessWidget {
   MobileLayout({super.key, required this.body});

  final Widget? body;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      key:scaffoldKey,
      drawer:const TSidebar(),
      appBar: THeader(scaffoldKey:scaffoldKey),
      body: body ?? Container(),
    );
  }
}
