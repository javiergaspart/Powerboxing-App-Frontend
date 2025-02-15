import 'package:flutter/material.dart';
import 'package:fitboxing_app/screens/dashboard/trainer_availability_screen.dart';
import 'package:fitboxing_app/screens/dashboard/session_management_screen.dart';

class TrainerDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Trainer Dashboard")),
      body: Column(
        children: [
          ListTile(
            title: Text("Manage Availability"),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => TrainerAvailabilityScreen())),
          ),
          ListTile(
            title: Text("Manage Sessions"),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SessionManagementScreen())),
          ),
        ],
      ),
    );
  }
}
