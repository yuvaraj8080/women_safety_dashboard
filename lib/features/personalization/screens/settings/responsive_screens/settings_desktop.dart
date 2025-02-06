import 'package:flutter/material.dart';
import 'package:women_safety_dashboard/utils/constants/sizes.dart';
import '../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../widgets/image_meta.dart';
import '../widgets/settings_form.dart';


class SettingsDesktopScreen extends StatelessWidget {
  const SettingsDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SingleChildScrollView(
        child:Padding(
          padding:const EdgeInsets.all(TSizes.sm8),
          child:Column(
            crossAxisAlignment:CrossAxisAlignment.start,
            children:[
              /// BREADCRUMBS
              TBreadcrumbWithHeading(heading:"Setting", breadcrumbItems:["Setting"],
              returnToPreviousScreen:true,
              ),
              const SizedBox(height:TSizes.sm8),

              /// BODY
              const Row(
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
