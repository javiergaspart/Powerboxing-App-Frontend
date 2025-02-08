import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  UserModel? _user;
  String? _authToken;  // ✅ Store the token
  final AuthService _authService = AuthService();

  UserModel? get user => _user;
  String? get authToken => _authToken;  // ✅ Provide access to the token

  Future<void> login(String email, String password) async {
    final loginResponse = await _authService.login(email, password);
    
    if (loginResponse != null) {
      _user = loginResponse.user;
      _authToken = loginResponse.token;  // ✅ Store the token after login
      notifyListeners();
    }
  }
}
