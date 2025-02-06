import 'package:flutter/material.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';

class TLoginHeader extends StatelessWidget {
  const TLoginHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Image(width:200, height: 150, image:AssetImage(TImages.AppLogo)),
            const SizedBox(height:TSizes.sm8),
            Text(TTexts.loginTitle,style:Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height:TSizes.sm8),
            Text(TTexts.loginSubTitle,style:Theme.of(context).textTheme.bodyMedium),

          ],
        )
    );
  }
}
