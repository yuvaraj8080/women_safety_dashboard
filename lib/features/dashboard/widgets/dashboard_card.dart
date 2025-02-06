import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';

class TDashboardCard extends StatelessWidget {
  const TDashboardCard({
    super.key,
    required this.title,
    required this.subTitle,
    this.icon = Iconsax.arrow_up_3,
    this.color = TColors.success,
    this.onTap,
  });

  final String title, subTitle;
  final IconData icon;
  final Color color;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
        showBorder: true,
        onTap: onTap,
        padding: const EdgeInsets.all(TSizes.md16),
        child: Column(
          crossAxisAlignment:CrossAxisAlignment.start,
            children: [
          /// HEADING
          TSectionHeading(title: title,textColor: TColors.textSecondary),
          const SizedBox(height: TSizes.sm8),
          Text(subTitle, style: Theme.of(context).textTheme.headlineSmall),

        ]));
  }
}
