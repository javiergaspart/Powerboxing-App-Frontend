import 'package:flutter/material.dart';
import 'package:fitboxing_app/services/auth_service.dart';
import 'package:fitboxing_app/models/user_model.dart';
import 'package:fitboxing_app/screens/dashboard/home_screen.dart';
import 'package:fitboxing_app/screens/auth/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  void _login() async {
    setState(() => _isLoading = true);

    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    UserModel? user = await AuthService.login(email, password);

    setState(() => _isLoading = false);

    if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen(user: user)),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Invalid email or password.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _emailController, decoration: InputDecoration(labelText: "Email")),
            TextField(controller: _passwordController, decoration: InputDecoration(labelText: "Password"), obscureText: true),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _login, child: Text("Login")),
            TextButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SignupScreen())),
              child: Text("Don't have an account? Sign Up"),
            ),
          ],
        ),
      ),
    );
  }
}
