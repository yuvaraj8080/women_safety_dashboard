import 'package:flutter/material.dart';
import 'package:flutter_admin_web/common/widgets/images/t_circular_image.dart';
import 'package:flutter_admin_web/routes/routes.dart';
import 'package:flutter_admin_web/utils/constants/colors.dart';
import 'package:flutter_admin_web/utils/constants/image_strings.dart';
import 'package:flutter_admin_web/utils/constants/sizes.dart';
import 'package:iconsax/iconsax.dart';
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
                        const TMenuItem(route:TRoutes.media,icon:Iconsax.image,itemName:"Media"),
                        const TMenuItem(route:TRoutes.categories,icon:Iconsax.category_2,itemName:"Categories"),
                        const TMenuItem(route:TRoutes.brands,icon:Iconsax.dcube,itemName:"Brands"),
                        const TMenuItem(route:TRoutes.banners,icon:Iconsax.picture_frame,itemName:"Banners"),
                        const TMenuItem(route:TRoutes.products,icon:Iconsax.note,itemName:"Products"),
                        const TMenuItem(route:TRoutes.customers,icon:Iconsax.profile_2user,itemName:"Customers"),
                        const TMenuItem(route:TRoutes.orders,icon:Iconsax.box,itemName:"Orders"),
                        const TMenuItem(route:TRoutes.profile,icon:Iconsax.user,itemName:"Profile"),
                        const TMenuItem(route:TRoutes.settings,icon:Iconsax.setting_2,itemName:"Settings"),
                ])
              )

            ],
          )
        )
      )
    );
  }
}

