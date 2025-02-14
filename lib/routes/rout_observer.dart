import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:women_safety_dashboard/routes/routes.dart';

import '../common/widgets/layouts/sidebars/menu/sidebar_controller.dart';

class RoutObservers extends GetObserver{

  /// CALLED WHEN A ROUT POPPED FROM THE NAVIGATION STACK
  @override
  void didPop(Route<dynamic>? route, Route<dynamic>? previousRoute){
    final  sidebarController = Get.put(SidebarController());

    if(previousRoute != null){
      /// CHECK THE ROUTE NAME AND UPDATES ITE IN THE SIDEBAR ACCORDINGLY
      for(var routeName in TRoutes.sidebarMenuItems){
        if(previousRoute.settings.name == routeName){
          sidebarController.activeItem.value = routeName;
        }
      }
    }
  }




  @override
  void didPush(Route<dynamic>? route, Route<dynamic>? previousRoute){
    final sidebarController = Get.put(SidebarController());

    if(route != null){
      /// CHECK THE ROUTE NAME AND UPDATES THE ACTIVE ITEM IN THE ACCORDINGLY
      for(var routeName in TRoutes.sidebarMenuItems){
        if(route.settings.name == routeName){
          sidebarController.activeItem.value = routeName;
        }
      }
    }
  }



}