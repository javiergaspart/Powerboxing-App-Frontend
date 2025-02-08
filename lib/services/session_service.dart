import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fitboxing_app/config.dart';

class SessionService {
  static Future<List<dynamic>> fetchAvailableSessions() async {
    final response = await http.get(Uri.parse('$API_BASE_URL/api/sessions'));
    return response.statusCode == 200 ? jsonDecode(response.body) : [];
  }

  static Future<bool> bookSession(String userId, String sessionId) async {
    final response = await http.post(
      Uri.parse('$API_BASE_URL/api/sessions/book'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({'userId': userId, 'sessionId': sessionId}),
    );
    return response.statusCode == 200;
  }
}
