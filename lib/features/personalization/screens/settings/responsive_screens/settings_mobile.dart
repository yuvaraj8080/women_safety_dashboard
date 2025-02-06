import 'package:flutter/material.dart';
import 'package:women_safety_dashboard/features/personalization/screens/settings/widgets/settings_form.dart';
import '../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../utils/constants/sizes.dart';
import '../widgets/image_meta.dart';



class SettingsMobileScreen extends StatelessWidget {
  const SettingsMobileScreen({super.key});

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
                    TBreadcrumbWithHeading(heading:"Profile", breadcrumbItems:["Profile"]),
                    SizedBox(height:TSizes.sm8),

                    /// BODY
                    Column(
                      children:[
                        /// PROFILE PIC AND META
                        ImageAndMeta(),
                        SizedBox(height:TSizes.sm8),

                        /// FORM
                        SettingsForm(),
                      ],
                    )
                  ]
              ),
            )
        )
    );
  }
}
