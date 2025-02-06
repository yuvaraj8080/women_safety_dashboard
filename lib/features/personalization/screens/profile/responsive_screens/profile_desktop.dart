import 'package:flutter/material.dart';
import '../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../utils/constants/sizes.dart';
import '../widgets/form.dart';
import '../widgets/image_meta.dart';

class ProfileDesktopScreen extends StatelessWidget {
  const ProfileDesktopScreen({super.key});

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
              TBreadcrumbWithHeading(heading:"Profile", breadcrumbItems:["Profile"],
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
                  Expanded(flex:2,child:ProfileForm()),
                ],
              )
            ]
          ),
        )
      )
    );
  }
}
