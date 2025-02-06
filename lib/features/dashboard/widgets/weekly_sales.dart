import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/device/device_utility.dart';
import '../dashboard/dashboard_controller.dart';

class YearlyCrimeReport extends StatelessWidget {
  const YearlyCrimeReport({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DashboardController());

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: TSizes.sm8),

          /// GRAPH
          Obx(() {
            return SizedBox(
                height: 200,
                child: BarChart(
                  BarChartData(
                      titlesData: buildFlTitlesData(),
                      borderData: FlBorderData(

                          show: true,
                          border: const Border(
                              top: BorderSide.none, right: BorderSide.none)),
                      gridData: const FlGridData(
                        show: true,
                        drawHorizontalLine: true,
                        drawVerticalLine: true,
                        horizontalInterval: 10,
                      ),
                      barGroups: controller.yearlyCrimeData
                          .asMap()
                          .entries
                          .map((entry) => BarChartGroupData(x: entry.key, barRods: [
                        BarChartRodData(
                          width: 16,
                          toY: entry.value,
                          color: TColors.primary,
                          borderRadius: BorderRadius.circular(TSizes.sm8),
                        )
                      ]))
                          .toList(),
                      groupsSpace: TSizes.spaceBtwItems16,
                      barTouchData: BarTouchData(
                          touchTooltipData: BarTouchTooltipData(
                              getTooltipColor: (_) => TColors.secondary),
                          touchCallback: TDeviceUtils.isDesktopScreen(context)
                              ? (barTouchEvent, barTouchResponse) {
                            // Your touch callback implementation here
                          }
                              : null)),
                ));
          })
        ]);
  }
}

FlTitlesData buildFlTitlesData() {
  return FlTitlesData(
      show: true,
      bottomTitles: AxisTitles(
          sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                final months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];

                ///CALCULATE THE INDEX AND ENSURE IT WRAPS AROUND FOR THE CORRECT MONTH
                final index = value.toInt() % months.length;

                /// GET THE MONTH CORRESPONDING TO THE CALCULATED INDEX
                final month = months[index];
                return SideTitleWidget(
                    space: 0, axisSide: AxisSide.bottom, child: Text(month, style: TextStyle(decoration: TextDecoration.none)));
              })),
      leftTitles: AxisTitles(
          sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                return Text('${value.toInt()}%', style: TextStyle(decoration: TextDecoration.none));
              })),
      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)));
}