import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:women_safety_dashboard/common/widgets/containers/rounded_container.dart';
import 'package:women_safety_dashboard/features/dashboard/dashboard/dashboard_controller.dart';
import '../../../utils/constants/sizes.dart';
import '../widgets/dashboard_card.dart';
import '../widgets/weekly_sales.dart';



class DashboardDesktopScreen extends StatelessWidget {
  const DashboardDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dashController = Get.put(DashboardController());
    return Scaffold(
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(TSizes.spaceBtwItems16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// HEADING
                  Text("Dashboard", style: Theme.of(context).textTheme
                      .headlineMedium),
                  const SizedBox(height: TSizes.sm8),

                  /// CARDS
                     Row(
                        children: [
                          Expanded(child: TDashboardCard(
                              title: 'Total Crime', subTitle:dashController.totalReportedIncidents.length.toString())),
                          const SizedBox(width: TSizes.ms12),
                           Expanded(child: TDashboardCard(
                              title: 'Solved Crime', subTitle:"9")),
                          const SizedBox(width: TSizes.ms12),
                          Expanded(child: TDashboardCard(
                              title: 'Unsolved Crime', subTitle:"5")),
                          const SizedBox(width: TSizes.ms12),
                          Expanded(child: TDashboardCard(
                              title: 'Pending Crime',subTitle: "20")),
                        ]),
                  const SizedBox(height: TSizes.ms12),

                  // / GRAPH IN THE DASHBOARD
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 2,
                            child: Column(
                                children: [
                                  TRoundedContainer(
                                    child:Column(
                                      children:[
                                        const YearlyCrimeReport(),

                                      ],
                                    ),
                                  ),

                                  /// ORDERS
                                  // TRoundedContainer(
                                  //     child: Column(
                                  //         crossAxisAlignment: CrossAxisAlignment
                                  //             .start,
                                  //         children: [
                                  //           Row(
                                  //             mainAxisAlignment:MainAxisAlignment.spaceBetween ,
                                  //             children: [
                                  //               Text("Recent 20 Orders", style: Theme.of(context).textTheme.headlineSmall),
                                  //               OutlinedButton(onPressed:()=> Get.offNamed(TRoutes.orders),
                                  //                   child:const Text("View All Orders"))
                                  //             ],
                                  //           ), const SizedBox(height: TSizes.xs4),
                                  //
                                  //           Obx(() {
                                  //             if(orderController.isLoading.value) return const TLoaderAnimation();
                                  //             return const DashboardOrderTable();
                                  //           }),
                                  //         ])
                                  // ),
                                ]
                            )),
                        const SizedBox(width: TSizes.sm8),

                        /// PIE CHART
                        // const Expanded(child: OrderStatusPieChart())
                      ]
                  )
                ],
              )
          ),
        )
    );
  }
}
