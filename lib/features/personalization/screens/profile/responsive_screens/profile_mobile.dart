import 'package:flutter/material.dart';

import '../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../utils/constants/sizes.dart';
import '../widgets/form.dart';
import '../widgets/image_meta.dart';

class ProfileMobileScreen extends StatelessWidget {
  const ProfileMobileScreen({super.key});

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
                        ProfileForm(),
                      ],
                    )
                  ]
              ),
            )
        )
    );
  }
}
