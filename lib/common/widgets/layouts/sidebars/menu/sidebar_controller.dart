import 'package:get/get.dart';

import '../../../../../routes/routes.dart';
import '../../../../../utils/device/device_utility.dart';

class SidebarController extends GetxController{

  //// ----- i ma changign hare some eror remember it and di=******* login is not corect
  final activeItem = TRoutes.dashboard.obs;
  final hoverItem = ''.obs;


  void changeActiveItem(String route) => activeItem.value = route;

  void changeHoverItem(String route){
    if(!isActive(route)) hoverItem.value = route;
  }

  bool isActive(String route) => activeItem.value == route;


  bool isHovering(String route) => hoverItem.value == route;


  void menuOnTap(String route){
    if(!isActive(route)){

      changeActiveItem(route);

      if(TDeviceUtils.isMobileScreen(Get.context!)) Get.back();

      Get.toNamed(route);

    }
  }


}