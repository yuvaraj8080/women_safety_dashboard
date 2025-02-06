import 'package:flutter/material.dart';
import 'package:flutter_admin_web/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:flutter_admin_web/utils/constants/sizes.dart';
import '../widgets/image_meta.dart';
import '../widgets/settings_form.dart';


class SettingsDesktopScreen extends StatelessWidget {
  const SettingsDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body:SingleChildScrollView(
        child:Padding(
          padding:EdgeInsets.all(TSizes.sm8),
          child:Column(
            crossAxisAlignment:CrossAxisAlignment.start,
            children:[
              /// BREADCRUMBS
              TBreadcrumbWithHeading(heading:"Setting", breadcrumbItems:["Setting"],
              returnToPreviousScreen:true,
              ),
              SizedBox(height:TSizes.sm8),

              /// BODY
              Row(
                crossAxisAlignment:CrossAxisAlignment.start,
                children:[
                  /// PROFILE PIC AND META
                  Expanded(child: ImageAndMeta()),
                  SizedBox(width:TSizes.sm8),

                  /// FORM
                  Expanded(flex:2,child:SettingsForm()),
                ],
              )
            ]
          ),
        )
      )
    );
  }
}
