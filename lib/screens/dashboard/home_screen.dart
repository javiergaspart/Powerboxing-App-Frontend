import 'package:flutter/material.dart';
import '../../models/user_model.dart';

class HomeScreen extends StatelessWidget {
  final UserModel user;

  HomeScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dashboard')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Welcome, ${user.username}', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Text('Available Sessions: ${user.sessionBalance}', style: TextStyle(fontSize: 18, color: Colors.green)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/reserve', arguments: user);
              },
              child: Text('View Sessions'),
            ),
          ],
        ),
      ),
    );
  }
}


