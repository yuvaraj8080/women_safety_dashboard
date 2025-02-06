import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/link.dart';
import 'package:women_safety_dashboard/common/widgets/layouts/sidebars/menu/sidebar_controller.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';

class TMenuItem extends StatelessWidget {
  const TMenuItem({super.key,required this.route, required this.icon, required this.itemName});

  final String route;
  final IconData icon;
  final String itemName;


  @override
  Widget build(BuildContext context) {

    final menuController = Get.put(SidebarController());

    return Link(
      uri:route != 'logout' ? Uri.parse(route) : null,
      builder: (_,__) => InkWell(
        onTap:()=> menuController.menuOnTap(route),
        onHover:(hovering)=> hovering ? menuController.changeHoverItem(route) : menuController.changeHoverItem(''),
        child: Obx(()=>Padding(
            padding: const EdgeInsets.symmetric(vertical:TSizes.xs4),
            child: Container(
                decoration:BoxDecoration(
                  color:menuController.isHovering(route) || menuController.isActive(route) ?TColors.primary : Colors.transparent,
                  borderRadius:BorderRadius.circular(TSizes.cardRadiusMd),
                ),
              child:Row(
                crossAxisAlignment:CrossAxisAlignment.center,
                children:[

                  /// ICON
                   Padding(
                    padding: const EdgeInsets.only(left:TSizes.lg24, top:TSizes.md16, bottom:TSizes.md16, right:TSizes.md16),
                    child: menuController.isActive(route)
                    ? Icon(icon, size:22, color:TColors.white)
                    : Icon(icon,size:22, color:menuController.isHovering(route) ? TColors.white : TColors.darkGrey),
                  ),

                  /// TEXT
                  if(menuController.isHovering(route) || menuController.isActive(route))
                      Flexible(child: Text(itemName,style:Theme.of(context).textTheme.bodyMedium!.apply(color:TColors.white)))
                  else
                      Flexible(child: Text(itemName,style: Theme.of(context).textTheme.bodyMedium!.apply(color:TColors.darkGrey))),
                ]
              )
            ),
          ),
        ),
      ),
    );
  }
}
