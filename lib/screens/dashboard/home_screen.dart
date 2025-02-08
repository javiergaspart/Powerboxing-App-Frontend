import 'package:flutter/material.dart';
import 'package:fitboxing_app/models/user_model.dart';
import 'package:fitboxing_app/screens/calendar/calendar_screen.dart';
import 'package:fitboxing_app/screens/sessions/buy_sessions_screen.dart';

class HomeScreen extends StatelessWidget {
  final UserModel user;
  HomeScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Welcome, ${user.name}")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Email: ${user.email}"),
            Text("Available Sessions: ${user.sessionBalance}"),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CalendarScreen(user: user))),
              child: Text("Book a Session"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => BuySessionsScreen(user: user))),
              child: Text("Buy Sessions"),
            ),
          ],
        ),
      ),
    );
  }
}
