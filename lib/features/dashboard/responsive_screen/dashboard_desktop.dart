import 'package:flutter/material.dart';
import 'package:women_safety_dashboard/common/widgets/containers/rounded_container.dart';
import '../../../utils/constants/sizes.dart';
import '../widgets/dashboard_card.dart';
import '../widgets/weekly_sales.dart';



class DashboardDesktopScreen extends StatelessWidget {
  const DashboardDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                              title: 'Total Crime', subTitle:"5000")),
                          const SizedBox(width: TSizes.ms12),
                           Expanded(child: TDashboardCard(
                              title: 'Solved Crime', subTitle:"159")),
                          const SizedBox(width: TSizes.ms12),
                          Expanded(child: TDashboardCard(
                              title: 'Unsolved Crime', subTitle:"57")),
                          const SizedBox(width: TSizes.ms12),
                          Expanded(child: TDashboardCard(
                              title: 'Pending Crime',subTitle: "470")),
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

                                        //// CRIME TREND HEADER AND CRIME TYPE SELECT BUTTON  ////
                                        Row(
                                          mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Crime Trends",style:Theme.of(context).textTheme.headlineSmall),
                                            OutlinedButton(onPressed:(){}, child:Text("Harassment"))
                                          ],
                                        ),
                                        /// CRIME TREND GRAPH
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
