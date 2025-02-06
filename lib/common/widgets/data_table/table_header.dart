import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/device/device_utility.dart';

class TTableHeader extends StatelessWidget {
  const TTableHeader({super.key, this.onPressed, this.buttonText = "Add", this.searchController, this.searchOnChanged,  this.showLeftWidget = true});

  final Function()? onPressed;
  final String buttonText;
  final TextEditingController? searchController;
  final Function(String)? searchOnChanged;
  final bool showLeftWidget;

  @override
  Widget build(BuildContext context) {
    return  Row(
      children:[
        /// CREATE NEW BUTTONS
        Expanded(
          flex:TDeviceUtils.isDesktopScreen(context) ? 3 : 1,
            child:showLeftWidget ?
            Row(
              children: [
                SizedBox(width:200,child: ElevatedButton(onPressed:onPressed,
                    child:Text(buttonText))),
              ],
            ):const SizedBox.shrink()
        ),

        /// SEARCH CATEGORY FUNCTION
        Expanded(
          flex:TDeviceUtils.isDesktopScreen(context) ? 2 : 1,
          child:TextFormField(
            controller:searchController,
            onChanged:searchOnChanged,
            decoration:const InputDecoration(hintText:"Search hare...", prefixIcon:Icon(Iconsax.search_normal)),
          )
        )
      ]
    );
  }
}
