import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://localhost:10000/fitboxing";

  /// **GET Request**
  static Future<Map<String, dynamic>?> get(String endpoint) async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/$endpoint"));

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {"success": false, "message": "Error ${response.statusCode}: ${response.body}"};
      }
    } catch (error) {
      return {"success": false, "message": "Network error: $error"};
    }
  }

  /// **POST Request**
  static Future<Map<String, dynamic>?> post(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/$endpoint"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        return {"success": false, "message": "Error ${response.statusCode}: ${response.body}"};
      }
    } catch (error) {
      return {"success": false, "message": "Network error: $error"};
    }
  }

  /// **DELETE Request**
  static Future<Map<String, dynamic>?> delete(String endpoint) async {
    try {
      final response = await http.delete(Uri.parse("$baseUrl/$endpoint"));

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {"success": false, "message": "Error ${response.statusCode}: ${response.body}"};
      }
    } catch (error) {
      return {"success": false, "message": "Network error: $error"};
    }
  }
}
