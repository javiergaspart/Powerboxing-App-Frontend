import 'package:flutter/material.dart';
import 'package:fitboxing_app/services/api_service.dart';

class TrainerAvailabilityScreen extends StatefulWidget {
  @override
  _TrainerAvailabilityScreenState createState() =>
      _TrainerAvailabilityScreenState();
}

class _TrainerAvailabilityScreenState extends State<TrainerAvailabilityScreen> {
  List<Map<String, dynamic>> selectedSlots = [];

  void saveAvailability() async {
    final Map<String, dynamic> payload = {
      "slots": selectedSlots,
    };

    var response = await ApiService.post(
      "fitboxing/sessions/save-availability",
      payload,
    );

    if (response != null && response is Map<String, dynamic>) {
      if (response.containsKey("success") && response["success"] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Availability saved successfully!")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response["message"] ?? "Error saving availability")),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Invalid response from server")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Trainer Availability")),
      body: Column(
        children: [
          Expanded(child: Center(child: Text("Availability calendar here"))),
          ElevatedButton(onPressed: saveAvailability, child: Text("Save Availability")),
        ],
      ),
    );
  }
}
