import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  UserModel? _user;
  final AuthService _authService = AuthService();

  UserModel? get user => _user;

  Future<void> login(String email, String password) async {
    _user = await _authService.login(email, password);
    notifyListeners();
  }
}
