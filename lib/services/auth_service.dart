import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService extends ChangeNotifier {
  final String apiUrl = "http://localhost:10000/fitboxing/auth";
  final storage = FlutterSecureStorage();
  Map<String, dynamic>? _loggedInUser;

  Map<String, dynamic>? get loggedInUser => _loggedInUser;

  Future<Map<String, dynamic>?> login(String email, String password) async {
    final response = await http.post(
      Uri.parse("$apiUrl/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      _loggedInUser = data["user"];
      await storage.write(key: "token", value: data["token"]);
      notifyListeners();
      return data;
    }
    return {"success": false, "message": "Invalid credentials"};
  }

  Future<Map<String, dynamic>?> signUp(String name, String email, String password) async {
    final response = await http.post(
      Uri.parse("$apiUrl/register"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"name": name, "email": email, "password": password}),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    }
    return {"success": false, "message": "Sign-up failed"};
  }

  void logout() {
    _loggedInUser = null;
    storage.delete(key: "token");
    notifyListeners();
  }
}
