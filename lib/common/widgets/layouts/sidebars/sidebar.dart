import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../images/t_circular_image.dart';
import 'menu/menu_items.dart';

class TSidebar extends StatelessWidget {
  const TSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape:const BeveledRectangleBorder(),
      child: Container(
        decoration:const BoxDecoration(
          color:TColors.white,
          border:Border(right:BorderSide(color:TColors.grey,width:1))
        ),
        child:SingleChildScrollView(
          child:Column(
            children:[

              /// IMAGE IS HARE
              const TCircularImage(width:100, height:100, image:TImages.AppLogo,backgroundColor:Colors.transparent),
              const SizedBox(height:TSizes.spaceBtwItems16),

              Padding(
                padding:const EdgeInsets.all(TSizes.md16),
                child:Column(
                  crossAxisAlignment:CrossAxisAlignment.start,
                    children:[
                      Text("MENU",style:Theme.of(context).textTheme.bodySmall!.apply(letterSpacingDelta:1.2)),

                      //MENU ITEMS
                        const TMenuItem(route:TRoutes.dashboard,icon:Iconsax.status,itemName:"Dashboard"),
                        const TMenuItem(route:TRoutes.profile,icon:Iconsax.user,itemName:"Profile"),
                        const TMenuItem(route:TRoutes.live_tracking,icon:Iconsax.location,itemName:"Live Tracking"),

                ])
              )

            ],
          )
        )
      )
    );
  }
}

