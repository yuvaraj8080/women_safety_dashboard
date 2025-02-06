import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:women_safety_dashboard/utils/constants/image_strings.dart';

import '../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../common/widgets/images/image_uploader.dart';
import '../../../../../utils/constants/enums.dart';
import '../../../../../utils/constants/sizes.dart';

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
