import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:ui';

class ReportWidget extends StatelessWidget {
  final String city;
  final String description;
  final String fullName;
  final String phoneNo;
  final DateTime time;
  final String type;

  const ReportWidget({
    Key? key,
    required this.city,
    required this.description,
    required this.fullName,
    required this.phoneNo,
    required this.time,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the current theme to adapt to light or dark mode
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.all(5),
      child: Stack(
        children: [
          // Glassmorphism background with dynamic shadow
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isDarkMode
                    ? [Colors.black.withOpacity(0.4), Colors.black.withOpacity(0.1)]
                    : [Colors.white.withOpacity(0.5), Colors.white.withOpacity(0.2)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: isDarkMode ? Colors.black54 : Colors.grey.withOpacity(0.3),
                  blurRadius: isDarkMode ? 12 : 8,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: isDarkMode
                        ? Colors.white.withOpacity(0.1)
                        : Colors.white.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isDarkMode
                          ? Colors.white.withOpacity(0.3)
                          : Colors.grey.withOpacity(0.3),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.location_on_outlined, 
                              color: isDarkMode ? Colors.redAccent : Colors.red[400], 
                              size: 20),
                          SizedBox(width:5),
                          Text(
                            city,
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: isDarkMode ? Colors.white : Colors.black87,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height:5),
                      Row(
                        children: [
                          Icon(Icons.label_important_outline, 
                              color: isDarkMode ? Colors.orangeAccent : Colors.orange[600], 
                              size: 20),
                          SizedBox(width:5),
                          Text(
                            'Type: $type',
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w500,
                              color: isDarkMode ? Colors.grey[300] : Colors.grey[800],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.description_outlined, 
                              color: isDarkMode ? Colors.blueAccent : Colors.blue[400], 
                              size: 20),
                          SizedBox(width: 5),
                          Expanded(
                            child: Text(
                              description,
                              style: TextStyle(
                                fontSize: 12.0,
                                color: isDarkMode ? Colors.white70 : Colors.black87,
                                fontStyle: FontStyle.italic,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height:5),
                      Row(
                        children: [
                          Icon(Icons.access_time_outlined, 
                              color: isDarkMode ? Colors.greenAccent : Colors.green[400], 
                              size:20),
                          SizedBox(width: 5 ),
                          Text(
                            DateFormat.yMMMd().add_jm().format(time.toLocal()),
                            style: TextStyle(
                              fontSize: 12.0,
                              color: isDarkMode ? Colors.grey[400] : Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height:5),
                      Row(
                        children: [
                          Icon(Icons.person_outline, 
                              color: isDarkMode ? Colors.purpleAccent : Colors.purple[400], 
                              size: 20),
                          SizedBox(width: 5),
                          Text(
                            fullName,
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w600,
                              color: isDarkMode ? Colors.white : Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
