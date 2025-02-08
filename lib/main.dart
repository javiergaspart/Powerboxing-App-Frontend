import 'package:flutter/material.dart';
import 'package:fitboxing_app/screens/auth/login_screen.dart';
import 'package:fitboxing_app/screens/auth/signup_screen.dart';
import 'package:fitboxing_app/screens/dashboard/home_screen.dart';
import 'package:fitboxing_app/screens/calendar/calendar_screen.dart';
import 'package:fitboxing_app/screens/sessions/buy_sessions_screen.dart';
import 'package:fitboxing_app/models/user_model.dart';
import 'package:fitboxing_app/services/auth_service.dart';

void main() {
  runApp(FitBoxingApp());
}

class FitBoxingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FitBoxing App',
      theme: ThemeData(primarySwatch: Colors.purple),
      home: FutureBuilder<UserModel?>(
        future: AuthService.getLoggedInUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else {
            return snapshot.data != null
                ? HomeScreen(user: snapshot.data!)
                : LoginScreen();
          }
        },
      ),
      routes: {
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignupScreen(),
        '/dashboard': (context) => HomeScreen(user: AuthService.loggedInUser!),
        '/calendar': (context) =>
            CalendarScreen(user: AuthService.loggedInUser!),
        '/buy-sessions': (context) =>
            BuySessionsScreen(user: AuthService.loggedInUser!),
      },
    );
  }
}
