import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final int sessionBalance; // Retrieve session balance

  HomeScreen({this.sessionBalance = 1});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home Dashboard")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Welcome to FitBoxing!", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Text("Session Balance: $sessionBalance", style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Future integration for buying sessions
              },
              child: Text("Buy More Sessions"),
            ),
          ],
        ),
      ),
    );
  }
}
