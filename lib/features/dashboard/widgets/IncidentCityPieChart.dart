import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common/widgets/containers/rounded_container.dart';
import '../../../utils/constants/sizes.dart';
import '../dashboard/dashboard_controller.dart';

class CityIncidentOverviewPieChart extends StatelessWidget {
  const CityIncidentOverviewPieChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DashboardController());

    return TRoundedContainer(
      padding: const EdgeInsets.all(8),
      showBorder: true,
      child: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        // Get the incident counts by city
        final cityIncidentPercentages = controller.getIncidentCountsByCity();
        final totalIncidents = cityIncidentPercentages.values.reduce((a, b) => a + b);

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Pie Chart Column
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("District Overview", style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 150,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        PieChart(
                          PieChartData(
                            sections: cityIncidentPercentages.entries.map((entry) {
                              final city = entry.key;
                              final count = entry.value;
                              return PieChartSectionData(
                                color: _getColorForCity(city), // Function to get color based on city
                                value: count.toDouble(),
                                title: totalIncidents > 0 ? '${(count / totalIncidents * 100).toStringAsFixed(1)}%' : '0%',
                                titleStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                radius: 30,
                              );
                            }).toList(),
                            centerSpaceRadius: 50, // Set the center space radius
                            pieTouchData: PieTouchData(
                              touchCallback: (FlTouchEvent event, pieTouchResponse) {
                                if (!event.isInterestedForInteractions || pieTouchResponse == null || pieTouchResponse.touchedSection == null) {
                                  controller.hoveredIndex.value = -1; // Reset hovered index
                                  return;
                                }
                                controller.hoveredIndex.value = pieTouchResponse.touchedSection!.touchedSectionIndex; // Update hovered index
                              },
                            ),
                          ),
                        ),
                        // Center Text
                        Obx(() {
                          if (controller.hoveredIndex.value == -1) {
                            return const Text('Total Incidents',
                              style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                            );
                          }
                          final entry = cityIncidentPercentages.entries.elementAt(controller.hoveredIndex.value);
                          return Text(
                            "${entry.key}",
                            style: TextStyle(fontSize:10, fontWeight: FontWeight.bold, color: _getColorForCity(entry.key)),
                          );
                        }),
                      ],
                    ),
                  ),
                  const SizedBox(height: TSizes.ms12),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }


// Function to get color based on city
  Color _getColorForCity(String city) {
    // Define a color mapping for each city
    switch (city) {
      case "Mumbai City":
        return Colors.red;
      case "Mumbai Suburban":
        return Colors.orange;
      case "Thane":
        return Colors.green;
      case "Palghar":
        return Colors.blue;
      case "Raigad":
        return Colors.purple;
      case "Ratnagiri":
        return Colors.teal;
      case "Sindhudurg":
        return Colors.cyan;
      case "Pune":
        return Colors.amber;
      case "Kolhapur":
        return Colors.indigo;
      case "Sangli":
        return Colors.lime;
      case "Satara":
        return Colors.brown;
      case "Solapur":
        return Colors.deepOrange;
      case "Nashik":
        return Colors.lightBlue;
      case "Ahmednagar":
        return Colors.lightGreen;
      case "Dhule":
        return Colors.pink;
      case "Jalgaon":
        return Colors.yellow;
      case "Nandurbar":
        return Colors.grey;
      case "Aurangabad":
        return Colors.redAccent;
      case "Beed":
        return Colors.blueAccent;
      case "Jalna":
        return Colors.greenAccent;
      case "Osmanabad":
        return Colors.purpleAccent;
      case "Latur":
        return Colors.tealAccent;
      case "Parbhani":
        return Colors.cyanAccent;
      case "Hingoli":
        return Colors.amberAccent;
      case "Nanded":
        return Colors.indigoAccent;
      case "Amravati":
        return Colors.limeAccent;
      case "Akola":
        return Colors.brown.shade100;
      case "Buldhana":
        return Colors.deepOrangeAccent;
      case "Washim":
        return Colors.lightBlueAccent;
      case "Yavatmal":
        return Colors.lightGreenAccent;
      case "Nagpur":
        return Colors.pinkAccent;
      case "Bhandara":
        return Colors.yellowAccent;
      case "Chandrapur":
        return Colors.grey.shade600;
      case "Gadchiroli":
        return Colors.red.shade300;
      case "Gondia":
        return Colors.blue.shade300;
      case "Wardha":
        return Colors.green.shade300;
      default:
        return Colors.grey; // Default color for unknown cities
    }
  }
}