// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../../../common/widgets/containers/rounded_container.dart';
// import '../../../../../utils/constants/colors.dart';
// import '../../../../../utils/constants/sizes.dart';
// import '../../../../../utils/device/device_utility.dart';
// import '../../../controller/dashboard/dashboard_controller.dart';
//
// class TWeeklySalesGraph extends StatelessWidget {
//   const TWeeklySalesGraph({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(DashboardController());
//
//     return TRoundedContainer(
//         child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//           Text("Weekly Sales", style: Theme.of(context).textTheme.headlineSmall),
//           const SizedBox(height: TSizes.xs4),
//
//           /// GRAPH
//           Obx(() {
//             return SizedBox(
//                 height: 200,
//                 child: BarChart(
//                   BarChartData(
//                       titlesData: buildFlTitlesData(),
//                       borderData: FlBorderData(
//                           show: true,
//                           border: const Border(
//                               top: BorderSide.none, right: BorderSide.none)),
//                       gridData: const FlGridData(
//                         show: true,
//                         drawHorizontalLine: true,
//                         drawVerticalLine: true,
//                         horizontalInterval: 200,
//                       ),
//                       barGroups: controller.weeklySales
//                           .asMap()
//                           .entries
//                           .map((entry) => BarChartGroupData(x: entry.key, barRods: [
//                         BarChartRodData(
//                           width: 30,
//                           toY: entry.value,
//                           color: TColors.primary,
//                           borderRadius: BorderRadius.circular(TSizes.sm8),
//                         )
//                       ]))
//                           .toList(),
//                       groupsSpace: TSizes.spaceBtwItems16,
//                       barTouchData: BarTouchData(
//                           touchTooltipData: BarTouchTooltipData(
//                               getTooltipColor: (_) => TColors.secondary),
//                           touchCallback: TDeviceUtils.isDesktopScreen(context)
//                               ? (barTouchEvent, barTouchResponse) {}
//                               : null)),
//                 ));
//           })
//         ]));
//   }
// }
// FlTitlesData buildFlTitlesData() {
//   return FlTitlesData(
//       show: true,
//       bottomTitles: AxisTitles(
//           sideTitles: SideTitles(
//               showTitles: true,
//               getTitlesWidget: (value, meta) {
//                 final days = ["Mon", 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
//
//                 ///CALCULATE THE INDEX AND ENSURE IT WRAPS AROUND FOR THE CORRECT DAY
//                 final index = value.toInt() % days.length;
//
//                 /// GET THE DAY CORRESPONDING TO THE CALCULATED INDEX
//                 final day = days[index];
//                 return SideTitleWidget(
//                     space: 0, axisSide: AxisSide.bottom, child: Text(day, style: TextStyle(decoration: TextDecoration.none)));
//               })),
//       rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
//       topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)));
// }