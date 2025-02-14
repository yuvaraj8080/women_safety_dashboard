import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../features/authentication/controller/user_controller.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/device/device_utility.dart';
import '../../images/t_rounded_image.dart';
import '../../shimmers/shimmer.dart';


/// HEADER WIDGET FOR THE APPLICATION
class THeader extends StatelessWidget implements PreferredSizeWidget {
  const THeader({super.key, this.scaffoldKey});


  /// GLOBAL KEY ACCESS THE SCAFFOLD STATE
  final GlobalKey<ScaffoldState>? scaffoldKey;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return Container(
        decoration: const BoxDecoration(
          color: TColors.white,
          border: Border(bottom: BorderSide(color: TColors.grey, width: 1)),
        ),
        padding: const EdgeInsets.symmetric(
            horizontal: TSizes.md16, vertical: TSizes.sm8),
        child: AppBar(
            automaticallyImplyLeading: false,

            /// MOBILE AND TABLET MENU DRAWER BAR
            leading: !TDeviceUtils.isDesktopScreen(context)
                ? IconButton(
                onPressed: () => scaffoldKey?.currentState?.openDrawer(),
                icon: const Icon(Iconsax.menu))
                : null,

            /// DESKTOP SEARCH FIELD
            title:Text("Women Safety",style:Theme.of(context).textTheme.headlineLarge),



            ///  ACTIONS ICON BUTTONS HARE
            actions: [

              /// SEARCH ICON ON MOBILE AND TABLET
              if(!TDeviceUtils.isDesktopScreen(context)) SizedBox(width: 200,
                  child:ElevatedButton(
                      onPressed:() => Get.offAllNamed(TRoutes.dashboard),
                      child:const Text("Refresh Dashboard"))
              ),

              /// NOTIFICATION ICON ON MOBILE AND TABLET
              IconButton(
                  onPressed: () {}, icon: const Icon(Iconsax.notification)),

              /// USER DATA
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(() {
                      return TRoundedImage(

                        width: 40,
                        height: 40,
                        padding: 2,
                        imageType: controller.user.value.profilePicture.isNotEmpty ? ImageType.network : ImageType.asset,
                        image: controller.user.value.profilePicture.isNotEmpty ? controller.user.value.profilePicture : TImages.user,
                      );
                    }),
                    const SizedBox(width: TSizes.sm8),

                    /// NAME AND EMAIL
                    if(!TDeviceUtils.isMobileScreen(context))
                      Obx(() {
                        return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              controller.loading.value
                                ? const TShimmerEffect(width:50, height: 13)
                                : Text(controller.user.value.fullName, style: Theme
                                  .of(context)
                                  .textTheme
                                  .titleLarge),
                              controller.loading.value
                              ?   const TShimmerEffect(width:50, height: 13)
                              :   Text(controller.user.value.email, style: Theme
                                  .of(context)
                                  .textTheme
                                  .labelMedium),
                            ]);
                      })
                  ])
            ]
        )
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize =>
      Size.fromHeight(TDeviceUtils.getAppBarHeight() + 15);
}
