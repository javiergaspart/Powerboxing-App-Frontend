import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fitboxing_app/config.dart';
import 'package:fitboxing_app/models/user_model.dart';

class AuthService {
  static UserModel? loggedInUser;

  /// ✅ **FIXED**: Get Logged-In User (For Persistent Login)
  static Future<UserModel?> getLoggedInUser() async {
    return loggedInUser; // Returns the stored user if already logged in
  }

  /// ✅ **FIXED**: Login Function
  static Future<UserModel?> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$API_BASE_URL/api/auth/login'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": email.trim().toLowerCase(),
        "password": password,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      loggedInUser = UserModel.fromJson(data['user']); // Store the user session
      return loggedInUser;
    } else {
      print("Login Failed: ${response.body}");
      return null;
    }
  }
}
