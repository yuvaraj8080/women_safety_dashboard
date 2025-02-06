import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../routes/routes.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/validators/validation.dart';
import '../../../controller/login_controller.dart';


class TLoginForm extends StatelessWidget {
  const TLoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());

    return Form(
        key: controller.loginFormKey,
        child: Padding(padding: const EdgeInsets.symmetric(
            vertical: TSizes.spaceBtwSections32),
            child: Column(
                children: [

                  /// EMAIL
                  TextFormField(
                      controller: controller.email,
                      validator: TValidator.validateEmail,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Iconsax.direct_right),
                        labelText: TTexts.email,
                      )
                  ),
                  const SizedBox(height: TSizes.spaceBtwInputFields16),

                  /// PASSWORD
                  Obx(() {
                    return TextFormField(
                        obscureText: controller.hidePassword.value,
                        controller: controller.password,
                        validator: (value) =>
                            TValidator.validateEmptyText("Password", value),
                        decoration: InputDecoration(
                          suffixIcon: IconButton(onPressed: () => controller.hidePassword.value =
                          !controller.hidePassword.value,
                              icon: Icon(controller.hidePassword.value ? Iconsax
                                  .eye_slash : Iconsax.eye)),
                          prefixIcon: const Icon(Iconsax.password_check),
                          labelText: TTexts.password,)
                    );
                  }),
                  const SizedBox(height: TSizes.spaceBtwInputFields16 / 2),

                  /// REMEMBER ME & FORGET PASSWORD
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      /// REMEMBER ME
                      Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Obx(() {
                              return Checkbox(value:controller.rememberMe.value,
                                  onChanged: (value)=> controller.rememberMe.value = value!);
                            }),
                            const Text(TTexts.rememberMe),
                          ]
                      ),

                      /// FORGET PASSWORD
                      TextButton(
                          onPressed: () => Get.toNamed(TRoutes.forgetPassword),
                          child: const Text(TTexts.forgetPassword))
                    ],),
                  const SizedBox(height: TSizes.defaultSpace24),

                  ///  SIGN IN BUTTON HARE
                  SizedBox(
                      width: double.infinity,

                     child: ElevatedButton(onPressed: ()=> controller.emailAndPasswordSignIn(), child: const Text(TTexts.signIn),
                      // child: ElevatedButton(onPressed: ()=> controller.registerAdmin(), child: const Text(TTexts.signIn),
                      )
                  )
                ]
            )
        )
    );
  }
}
