import 'package:flutter/material.dart';

import '../../layouts/headers/header.dart';
import '../../layouts/sidebars/sidebar.dart';

class DesktopLayout extends StatelessWidget {
  const DesktopLayout({super.key, this.body});

  final Widget? body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Row(
        children:[
          const Expanded(child:TSidebar()),
          Expanded(
            flex:5,child:Column(
              children: [

              ///  CUSTOM HEADER HARE
                const THeader(),

              /// BODY
               Expanded(child: body ?? const SizedBox())
              ],
            )
          )
        ]
      ),
    );
  }
}
