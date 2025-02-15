import 'dart:convert';
import 'package:http/http.dart' as http;

class TrainerService {
  static const String API_BASE_URL = "http://localhost:10000/api/trainer";

  static Future<Map<String, bool>> getAvailability(String trainerId) async {
    final response = await http.get(Uri.parse("$API_BASE_URL/availability/$trainerId"));
    if (response.statusCode == 200) {
      return Map<String, bool>.from(jsonDecode(response.body));
    } else {
      return {};
    }
  }

  static Future<bool> saveAvailability(String trainerId, Map<String, bool> availability) async {
    final response = await http.post(
      Uri.parse("$API_BASE_URL/availability/$trainerId"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(availability),
    );
    return response.statusCode == 200;
  }

  static Future<List<Map<String, dynamic>>> getSessions(String trainerId) async {
    final response = await http.get(Uri.parse("$API_BASE_URL/sessions/$trainerId"));
    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(jsonDecode(response.body));
    } else {
      return [];
    }
  }

  static Future<bool> assignBoxer(String sessionId, String boxerId) async {
    final response = await http.post(
      Uri.parse("$API_BASE_URL/assign/$sessionId"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"boxerId": boxerId}),
    );
    return response.statusCode == 200;
  }

  static Future<bool> startSession(String sessionId) async {
    final response = await http.post(Uri.parse("$API_BASE_URL/start/$sessionId"));
    return response.statusCode == 200;
  }
}
