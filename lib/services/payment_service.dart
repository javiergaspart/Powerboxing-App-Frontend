// lib/services/payment_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class PaymentService {
  static Future<bool> purchaseSessions(String userId, int count) async {
    final response = await http.post(
      Uri.parse('http://localhost:10000/api/payments/buy-sessions'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'userId': userId, 'sessionCount': count}),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
