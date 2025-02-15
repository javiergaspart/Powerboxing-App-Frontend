import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fitboxing_app/services/auth_service.dart';

class UserDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final user = authService.loggedInUser;

    return Scaffold(
      appBar: AppBar(title: Text("User Dashboard")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Welcome, ${user?['name'] ?? 'User'}", style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            Text("Session Balance: ${user?['session_balance'] ?? 'N/A'}", style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            
            // BOOK SESSION BUTTON
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/book_session");
              },
              child: Text("Book a Session"),
            ),

            SizedBox(height: 10),

            // BUY SESSIONS BUTTON
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/buy_sessions");
              },
              child: Text("Buy Sessions"),
            ),

            SizedBox(height: 20),

            // LOGOUT BUTTON
            ElevatedButton(
              onPressed: () {
                authService.logout();
                Navigator.pushReplacementNamed(context, "/login");
              },
              child: Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }
}
