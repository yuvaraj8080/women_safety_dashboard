import 'package:flutter/material.dart';
import '../../../utils/constants/sizes.dart';
import '../widgets/dashboard_card.dart';
import '../widgets/order_status_graph.dart';


class DashboardDesktopScreen extends StatelessWidget {
  const DashboardDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final controller = Get.put(DashboardController());
    // final orderController = Get.put(OrderController());
    // final customerController = Get.put(CustomerController());
    return Scaffold(
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(TSizes.spaceBtwItems16),
              // child: Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //
              //     /// HEADING
              //     Text("Dashboard", style: Theme
              //         .of(context)
              //         .textTheme
              //         .headlineLarge),
              //     const SizedBox(height: TSizes.sm8),
              //
              //     /// CARDS
              //     Obx(() {
              //       final totalOrders = orderController.allItems.length.toString();
              //       final totalCustomers = customerController.allItems.length.toString();
              //       final totalSales = orderController.allItems.fold(
              //           0.0, (previousValue, element) => previousValue + element.totalAmount);
              //
              //       return Row(
              //           children: [
              //             Expanded(child: TDashboardCard(
              //                 title: 'Total Sales', subTitle: '₹$totalSales')),
              //             const SizedBox(width: TSizes.sm8),
              //              Expanded(child: TDashboardCard(
              //                 title: 'Weekly Total Sales', subTitle: '₹${controller.totalWeeklySales.value.toString()}')),
              //             const SizedBox(width: TSizes.sm8),
              //             Expanded(child: TDashboardCard(
              //                 title: 'total Orders', subTitle: totalOrders)),
              //             const SizedBox(width: TSizes.sm8),
              //             Expanded(child: TDashboardCard(
              //                 title: 'Visitors',
              //                 subTitle: "$totalCustomers users")),
              //           ]);
              //     }),
              //     const SizedBox(height: TSizes.sm8),
              //
              //     /// GRAPH IN THE DASHBOARD
              //     Row(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Expanded(flex: 2,
              //               child: Column(
              //                   children: [
              //
              //                     /// BAR GRAPH
              //                     const TWeeklySalesGraph(),
              //                     const SizedBox(height: TSizes.sm8),
              //
              //
              //                     /// ORDERS
              //                     TRoundedContainer(
              //                         child: Column(
              //                             crossAxisAlignment: CrossAxisAlignment
              //                                 .start,
              //                             children: [
              //                               Row(
              //                                 mainAxisAlignment:MainAxisAlignment.spaceBetween ,
              //                                 children: [
              //                                   Text("Recent 20 Orders", style: Theme.of(context).textTheme.headlineSmall),
              //                                   OutlinedButton(onPressed:()=> Get.offNamed(TRoutes.orders),
              //                                       child:const Text("View All Orders"))
              //                                 ],
              //                               ), const SizedBox(height: TSizes.xs4),
              //
              //                               Obx(() {
              //                                 if(orderController.isLoading.value) return const TLoaderAnimation();
              //                                 return const DashboardOrderTable();
              //                               }),
              //                             ])
              //                     ),
              //                   ]
              //               )),
              //           const SizedBox(width: TSizes.sm8),
              //
              //           /// PIE CHART
              //           const Expanded(child: OrderStatusPieChart())
              //         ]
              //     )
              //   ],
              // )
          ),
        )
    );
  }
}
