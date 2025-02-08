// lib/screens/sessions/buy_sessions_screen.dart
import 'package:flutter/material.dart';
import 'package:fitboxing_app/models/user_model.dart';
import 'package:fitboxing_app/services/payment_service.dart'; // ✅ Make sure this is correctly imported

class BuySessionsScreen extends StatelessWidget {
  final UserModel user;
  BuySessionsScreen({required this.user});

  void _purchaseSession(int count, BuildContext context) async {
    bool success = await PaymentService.purchaseSessions(user.id, count);
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$count sessions purchased successfully!')),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Purchase failed, please try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Buy Sessions')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () => _purchaseSession(1, context),
              child: Text('Buy 1 Session'),
            ),
            ElevatedButton(
              onPressed: () => _purchaseSession(5, context),
              child: Text('Buy 5 Sessions'),
            ),
            ElevatedButton(
              onPressed: () => _purchaseSession(10, context),
              child: Text('Buy 10 Sessions'),
            ),
            ElevatedButton(
              onPressed: () => _purchaseSession(20, context),
              child: Text('Buy 20 Sessions'),
            ),
          ],
        ),
      ),
    );
  }
}
