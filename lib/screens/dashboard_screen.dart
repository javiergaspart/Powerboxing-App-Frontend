import 'package:flutter/material.dart';
import 'package:fitboxing_app/services/auth_service.dart';
import 'package:fitboxing_app/models/user_model.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  UserModel? user;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    print("🔹 Fetching User Data from AuthService");
    UserModel? fetchedUser = await AuthService.getUserData();
    
    if (fetchedUser != null) {
      print("✅ User Data Received: ${fetchedUser.toJson()}");
      setState(() {
        user = fetchedUser;
      });
    } else {
      print("❌ Failed to Fetch User Data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome, ${user?.name ?? "Guest"}',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              'Available Sessions: ${user?.sessionBalance ?? 0}',
              style: TextStyle(fontSize: 18, color: Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}
