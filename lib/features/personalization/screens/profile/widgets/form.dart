import 'package:flutter/material.dart';
import 'package:flutter_admin_web/common/widgets/containers/rounded_container.dart';
import 'package:flutter_admin_web/features/authentication/controller/user_controller.dart';
import 'package:flutter_admin_web/utils/constants/sizes.dart';
import 'package:flutter_admin_web/utils/validators/validation.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ProfileForm extends StatelessWidget {
  const ProfileForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());

    return Column(
      children: [
        TRoundedContainer(
          padding: const EdgeInsets.symmetric(vertical: TSizes.sm8, horizontal: TSizes.sm8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Profile Details", style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: TSizes.sm8),

              /// FIRST AND LAST NAME
              Form(
                key:controller.adminFormKey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        /// FIRST NAME
                        Expanded(
                          child: TextFormField(
                            controller: controller.firstNameController,
                            decoration: const InputDecoration(
                              hintText: "First Name",
                              label: Text("First Name"),
                              prefixIcon: Icon(Iconsax.user),
                            ),
                            validator: (value) => TValidator.validateEmptyText("First Name", value),
                          ),
                        ),
                        const SizedBox(width: TSizes.sm8),

                        /// LAST NAME
                        Expanded(
                          child: TextFormField(
                            controller: controller.lastNameController,
                            decoration: const InputDecoration(
                              hintText: "Last Name",
                              label: Text("Last Name"),
                              prefixIcon: Icon(Iconsax.user),
                            ),
                            validator: (value) => TValidator.validateEmptyText("Last Name", value),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems16),

                    /// EMAIL AND PHONE
                    Row(
                      children: [
                        /// Email
                        Expanded(
                          child: TextFormField(
                            controller: controller.emailController,
                            decoration: const InputDecoration(
                              hintText: "Email",
                              label: Text("Email"),
                              enabled: false,
                              prefixIcon: Icon(Iconsax.forward),
                            ),
                          ),
                        ),
                        const SizedBox(width: TSizes.sm8),

                        /// MOBILE NUMBER
                        Expanded(
                          child: TextFormField(
                            controller: controller.phoneNumberController,
                            decoration: const InputDecoration(
                              hintText: "Phone Number",
                              label: Text("Phone Number"),
                              prefixIcon: Icon(Iconsax.user),
                            ),
                            validator: (value) => TValidator.validateEmptyText("Phone Number", value),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwSections32),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        controller.updateAdminDetails();
                      },
                      child: const Text("Update Profile"),
                    ),
                  ),
                  const SizedBox(width:50),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        controller.confirmLogoutUser();
                      },
                      child: const Text("Logout Account"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}