import 'package:flutter/material.dart';
import 'package:flutter_admin_web/common/widgets/containers/rounded_container.dart';
import 'package:flutter_admin_web/common/widgets/images/image_uploader.dart';
import 'package:flutter_admin_web/utils/constants/enums.dart';
import 'package:flutter_admin_web/utils/constants/image_strings.dart';
import 'package:flutter_admin_web/utils/constants/sizes.dart';
import 'package:iconsax/iconsax.dart';

class ImageAndMeta extends StatelessWidget {
  const ImageAndMeta({super.key});

  @override
  Widget build(BuildContext context) {
    return  TRoundedContainer(
      padding:const EdgeInsets.symmetric(vertical:TSizes.spaceBtwItems16,horizontal:TSizes.spaceBtwItems16),
      child:Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              /// USER IMAGE
               const TImageUploader(
                right:20,bottom:20,left:null,width:150,height:150,
                circular:true,
                icon: Iconsax.camera,image:TImages.user,
                imageType:ImageType.asset,
              ),
               const SizedBox(height:TSizes.sm8),
              Text("Yuvaraj Dekhane",style:Theme.of(context).textTheme.headlineLarge),
              const Text("teamloading8080@gmail.com"),
              const SizedBox(height:TSizes.sm8),
            ],
          )
        ],
      ),
    );
  }
}
