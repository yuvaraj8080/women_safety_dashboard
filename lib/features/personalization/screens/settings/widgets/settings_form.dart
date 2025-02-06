import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';
import 'package:women_safety_dashboard/utils/validators/validation.dart';
import '../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../controller/setting_controller.dart';

class SettingsForm extends StatelessWidget {
  const SettingsForm({super.key});

  @override
  Widget build(BuildContext context) {
    final  settingController = Get.put(SettingController()); // Get the controller instance

    return Column(
      children: [
        TRoundedContainer(
          padding: const EdgeInsets.symmetric(vertical: TSizes.sm8, horizontal: TSizes.sm8),
          child: Form(
            key: settingController.settingFormKey, // Assign the form key
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("App Settings", style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: TSizes.sm8),

                /// APP NAME
                TextFormField(
                  controller: settingController.appNameController, // Assign controller
                  decoration: const InputDecoration(
                    hintText: "App Name",
                    label: Text("App Name"),
                    prefixIcon: Icon(Iconsax.user),
                  ),
                  validator: (value) => TValidator.validateEmptyText(value, "App Name is required"), // Use your validator
                ),
                const SizedBox(height: TSizes.sm8),

                /// TAX RATE, SHIPPING RATE, AND THRESHOLD
                Row(
                  children: [
                    /// TAX RATE
                    Expanded(
                      child: TextFormField(
                        controller: settingController.taxRateController, // Assign controller
                        decoration: const InputDecoration(
                          hintText: "Tax %",
                          label: Text("Tax Rate (%)"),
                          prefixIcon: Icon(Iconsax.tag),
                        ),
                        validator: (value) => TValidator.validateEmptyText(value, "Tax Rate is required"), // Use your validator
                      ),
                    ),
                    const SizedBox(width: TSizes.sm8),

                    /// SHIPPING RATE
                    Expanded(
                      child: TextFormField(
                        controller: settingController.shippingRateController, // Assign controller
                        decoration: const InputDecoration(
                          hintText: "Shipping Cost",
                          label: Text("Shipping Rate (\$)"),
                          prefixIcon: Icon(Iconsax.ship),
                        ),
                        validator: (value) => TValidator.validateEmptyText(value, "Shipping Rate is required"), // Use your validator
                      ),
                    ),
                    const SizedBox(width: TSizes.sm8),

                    /// SHIPPING THRESHOLD
                    Expanded(
                      child: TextFormField(
                        controller: settingController.threshHoldController, // Assign controller
                        decoration: const InputDecoration(
                          hintText: "Free Shipping After(\$)",
                          label: Text("Shipping Threshold (\$)"),
                          prefixIcon: Icon(Iconsax.ship),
                        ),
                        validator: (value) => TValidator.validateEmptyText(value, "Shipping Threshold is required"), // Use your validator
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwSections32),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      settingController.addSettingDetails(); // Call the update method in the controller
                    },
                    child: const Text("Update App Settings"),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
