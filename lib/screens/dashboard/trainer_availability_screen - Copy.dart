import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class TrainerAvailabilityScreen extends StatefulWidget {
  @override
  _TrainerAvailabilityScreenState createState() => _TrainerAvailabilityScreenState();
}

class _TrainerAvailabilityScreenState extends State<TrainerAvailabilityScreen> {
  List<String> selectedSlots = [];
  DateTime today = DateTime.now();

  List<DateTime> generateNextWeeks() {
    List<DateTime> dates = [];
    DateTime startDate = today;

    for (int i = 0; i < 8; i++) {
      for (int j = 0; j < 7; j++) {
        DateTime day = startDate.add(Duration(days: (i * 7) + j));
        if (i == 0 && day.isBefore(today)) continue;
        dates.add(day);
      }
    }
    return dates;
  }

  void toggleSlot(String slot) {
    setState(() {
      if (selectedSlots.contains(slot)) {
        selectedSlots.remove(slot);
      } else {
        selectedSlots.add(slot);
      }
    });
  }

  void saveSelection() async {
    final response = await http.post(
      Uri.parse('http://localhost:10000/fitboxing/sessions/reserve-or-create'), // Correct API route
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'trainerId': 'loggedInUser["_id"]', 'slots': selectedSlots}),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Sessions created successfully")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error creating sessions")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    List<DateTime> dates = generateNextWeeks();

    return Scaffold(
      appBar: AppBar(title: Text("Trainer Availability")),
      body: Stack(
        children: [
          ListView(
            children: [
              for (int week = 0; week < 8; week++)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: Text(
                        "Week ${week + 1}",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Table(
                      border: TableBorder.all(color: Colors.black),
                      children: [
                        TableRow(
                          children: List.generate(7, (day) {
                            if (week == 0 && dates[week * 7 + day].isBefore(today)) {
                              return TableCell(child: Container()); // Skip past days
                            }
                            return TableCell(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Text(
                                      "${DateFormat.E().format(dates[week * 7 + day])} ${DateFormat('dd/MM').format(dates[week * 7 + day])}",
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  for (int hour = 8; hour <= 20; hour++)
                                    GestureDetector(
                                      onTap: () => toggleSlot("${dates[week * 7 + day]} $hour:00"),
                                      child: Container(
                                        margin: EdgeInsets.all(4),
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: selectedSlots.contains("${dates[week * 7 + day]} $hour:00")
                                              ? Colors.green
                                              : Colors.red,
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "${hour}:00",
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  ],
                ),
              SizedBox(height: 100), // Ensure scrolling doesn't cover button
            ],
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: ElevatedButton(
              onPressed: selectedSlots.isNotEmpty ? saveSelection : null, // Disable if no slots selected
              child: Text("Save Availability"),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 12),
                textStyle: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
