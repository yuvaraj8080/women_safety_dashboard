import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../routes/routes.dart';
import '../../../utils/constants/sizes.dart';
import '../texts/page_heading.dart';

class TBreadcrumbWithHeading extends StatelessWidget {
  const TBreadcrumbWithHeading({
    super.key,
    required this.heading,
    required this.breadcrumbItems,
    this.returnToPreviousScreen = false

  });

  /// THE HEADING FOR THE PAGE
  final String heading;

  /// LIST OF BREADCRUMB ITEMS RESENTING THE NAVIGATION PATH
  final List<String> breadcrumbItems;

  /// FLAG INDICTING WHETHER TO INCLUDE A BUTTON TO RETURN TO THE PREVIOUS SCREEN
  final bool returnToPreviousScreen;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:[
        /// BREADCRUMB TRAIL
        Row(
          children: [
            InkWell(
              onTap: ()=> Get.offAllNamed(TRoutes.dashboard),
              child: Text("Dashboard", style:Theme.of(context).textTheme.bodySmall!.apply(fontWeightDelta:-1)),
            ),
            for(int i = 0;  i < breadcrumbItems.length; i++)
              Row(
                children:[
                   const Text('/'),/// SEPRATOR
                  InkWell(
                   /// LAST ITEM SHOULD NOT BE CLICKABLE
                    onTap:i == breadcrumbItems.length -1 ? null: () => Get.toNamed(breadcrumbItems[i]),
                    child:Padding(
                      padding: const EdgeInsets.all(TSizes.xs4),

                      ///FORMAT BREADCRUMB CAPITILIZE ARE REMOVE LEADING
                      child:Text(
                          i == breadcrumbItems.length - 1
                              ? breadcrumbItems[i].capitalize.toString()
                              : capitalize(breadcrumbItems[i].substring(1)),
                          style:Theme.of(context).textTheme.bodySmall!.apply(fontWeightDelta: -1))
                    )
                  )
                ]
              )
          ]
        ),
        /// HEADING OF THE PAGE
        Row(children: [
          if(returnToPreviousScreen) IconButton(onPressed:()=> Get.back(), icon:const Icon(Iconsax.arrow_left)),
          TPageHeading(heading:heading)
        ],)
      ]
    );
  }

  /// FUNCTION TO CAPITALIZE THE FIRST OF STRING
  String capitalize(String s){
    return s.isEmpty ? '' : s[0].toUpperCase() + s.substring(1);
  }
}
