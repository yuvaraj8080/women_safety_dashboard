import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../routes/routes.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';

class ResetPasswordWidget extends StatelessWidget {
  const ResetPasswordWidget({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    final email = Get.parameters['email']??'';
    return Column(
      children: [
        /// HEADER
        Align(alignment:Alignment.topRight,
            child: IconButton(onPressed:()=> Get.back(), icon:const Icon(CupertinoIcons.clear,))),
        const SizedBox(height:TSizes.spaceBtwItems16),


        /// TITLES AND SUBTITLE
        Text(TTexts.changeYourPasswordTitle,style:Theme.of(context).textTheme.headlineMedium,textAlign:TextAlign.center),
        const SizedBox(height:TSizes.spaceBtwItems16),
        Text(email, textAlign:TextAlign.center,style:Theme.of(context).textTheme.labelLarge),
        const SizedBox(height:TSizes.spaceBtwItems16),
        Text(TTexts.forgetPasswordSubTitle,style:Theme.of(context).textTheme.labelMedium,textAlign:TextAlign.center),
        const SizedBox(height:TSizes.spaceBtwItems16),


        /// BUTTONS ARE HARE
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(onPressed:()=>Get.offAllNamed(TRoutes.login),child:const Text(TTexts.done)),
        ),
        const SizedBox(height:TSizes.spaceBtwItems16),
        SizedBox(
          width: double.infinity,
          child: TextButton(onPressed:(){},child:const Text(TTexts.resendEmail)),
        ),
      ],
    );
  }
}
