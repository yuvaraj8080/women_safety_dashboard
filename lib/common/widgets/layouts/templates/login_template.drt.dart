import 'package:flutter/material.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../styles/spacing_styles.dart';



class TLoginTemplate extends StatelessWidget {
  const TLoginTemplate({
    super.key, required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
        child:SizedBox(
            width: 500,
            child:SingleChildScrollView(
                child:Container(
                    padding:TSpacingStyle.paddingWithAppBarHeight,
                    decoration:BoxDecoration(
                        color:TColors.white,
                        borderRadius:BorderRadius.circular(TSizes.cardRadiusLg)
                    ),
                    child:child
                )
            )
        )
    );
  }
}
