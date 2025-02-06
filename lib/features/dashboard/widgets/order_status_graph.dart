// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_admin_web/common/widgets/containers/circular_container.dart';
// import 'package:flutter_admin_web/common/widgets/containers/rounded_container.dart';
// import 'package:flutter_admin_web/features/shop/controller/dashboard/dashboard_controller.dart';
// import 'package:flutter_admin_web/utils/constants/sizes.dart';
// import 'package:flutter_admin_web/utils/helpers/helper_functions.dart';
// import 'package:get/get.dart';
// import '../../../../../common/widgets/loaders/loader_animation.dart';
// import '../../../../../utils/constants/enums.dart';
//
//
// class OrderStatusPieChart extends StatelessWidget {
//   const OrderStatusPieChart({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(DashboardController());
//
//     return Obx(() {
//       if (controller.isLoading.value) {
//         return const Center(child:TLoaderAnimation());
//       }
//
//       return TRoundedContainer(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("Order Status", style: Theme.of(context).textTheme.headlineSmall),
//             const SizedBox(height: TSizes.sm8),
//
//             /// GRAPH
//             SizedBox(
//               height: 200,
//               child: PieChart(
//                 PieChartData(
//                   sections: controller.orderStatusData.entries.map((entry) {
//                     final status = entry.key;
//                     final count = entry.value;
//
//                     return PieChartSectionData(
//                       radius: 60,
//                       color: THelperFunctions.getOrderStatusColor(status),
//                       title: count.toString(),
//                       value: count.toDouble(),
//                       titleStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
//                     );
//                   }).toList(),
//                   pieTouchData: PieTouchData(
//                     touchCallback: (FlTouchEvent event, pieTouchResponse) {
//                       /// HANDLE TOUCH EVENTS HARE IF NEEDED
//                     },
//                     enabled: true,
//                   ),
//                 ),
//               ),
//             ),
//
//             /// SHOW STATUS AND COLOR META HARE
//             SizedBox(
//               width: double.infinity,
//               child: DataTable(
//                 columns: const [
//                   DataColumn(label: Text("Status")),
//                   DataColumn(label: Text("Orders")),
//                   DataColumn(label: Text("Total")),
//                 ],
//                 rows: controller.orderStatusData.entries.map((entry) {
//                   final OrderStatus status = entry.key;
//                   final int count = entry.value;
//                   final totalAmount = controller.totalAmounts[status] ?? 0;
//                   return DataRow(cells: [
//                     DataCell(
//                       Row(
//                         children: [
//                           TCircularContainer(width: 15, height: 15, backgroundColor: THelperFunctions.getOrderStatusColor(status)),
//                           Expanded(child: Text(controller.getDisplayStatusName(status))),
//                         ],
//                       ),
//                     ),
//                     DataCell(Text(count.toString())),
//                     DataCell(Text("₹${totalAmount.toStringAsFixed(2)}")),
//                   ]);
//                 }).toList(),
//               ),
//             ),
//           ],
//         ),
//       );
//     });
//   }
// }