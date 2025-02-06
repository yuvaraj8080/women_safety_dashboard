import 'package:flutter/material.dart';

class DashboardMobileScreen extends StatelessWidget {
  const DashboardMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final controller = Get.put(DashboardController());
    // final orderController = Get.put(OrderController());
    // final customerController = Get.put(CustomerController());
    return Scaffold(
      body: SingleChildScrollView(
          // child: Padding(
          //     padding: const EdgeInsets.all(TSizes.spaceBtwItems16),
          //     child: Obx(() {
          //
          //       final totalOrders = orderController.allItems.length.toString();
          //       final totalCustomers = customerController.allItems.length.toString();
          //       final totalSales = orderController.allItems.fold(0.0, (previousValue,element) => previousValue + element.totalAmount);
          //
          //
          //       return Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //
          //           /// HEADING
          //           Text("Dashboard", style: Theme.of(context).textTheme.headlineMedium),
          //           const SizedBox(height: TSizes.ms12),
          //
          //           /// CARDS
          //           TDashboardCard(
          //               title: 'Total Sales', subTitle:'₹ $totalSales'),
          //           const SizedBox(height: TSizes.sm8),
          //           const TDashboardCard(
          //               title: 'Average order value', subTitle: '\$25'),
          //           const SizedBox(height: TSizes.sm8),
          //           TDashboardCard(
          //               title: 'total Orders', subTitle: totalOrders),
          //           const SizedBox(height: TSizes.sm8),
          //           TDashboardCard(
          //               title: 'Visitors', subTitle:"$totalCustomers users"),
          //
          //           const SizedBox(height: TSizes.sm8),
          //
          //           /// BAR GRAPH
          //           const TWeeklySalesGraph(),
          //           const SizedBox(height: TSizes.sm8),
          //
          //           /// ORDERS
          //
          //           TRoundedContainer(
          //               child: Column(
          //                   crossAxisAlignment: CrossAxisAlignment.start,
          //                   children: [
          //                     Row(
          //                       mainAxisAlignment:MainAxisAlignment.spaceBetween ,
          //                       children: [
          //                         Text("Recent 20 Orders", style: Theme.of(context).textTheme.headlineSmall),
          //                         OutlinedButton(onPressed:()=> Get.offNamed(TRoutes.orders),
          //                             child:const Text("View All Orders"))
          //                       ],
          //                     ), const SizedBox(height: TSizes.xs4),
          //                     Obx(() {
          //                       if(orderController.isLoading.value) return const TLoaderAnimation();
          //                       return const DashboardOrderTable();
          //                     }),
          //                   ])
          //           ), const SizedBox(height: TSizes.sm8),
          //
          //           /// PIE CHART
          //           const OrderStatusPieChart()
          //
          //         ],
          //       );
          //     })
          // )
      ),
    );
  }
}
