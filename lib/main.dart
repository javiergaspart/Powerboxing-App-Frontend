import 'package:flutter/material.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/signup_screen.dart';
import 'screens/dashboard/home_screen.dart';
import 'screens/dashboard/reservation_screen.dart';
import 'models/user_model.dart';

void main() {
  runApp(FitBoxingApp());
}

class FitBoxingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FitBoxing App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/signup': (context) => SignupScreen(),
        '/dashboard': (context) {
          final user = ModalRoute.of(context)!.settings.arguments as UserModel?;
          return HomeScreen(user: user ?? UserModel.defaultUser());
        },
        '/reserve': (context) {
          final user = ModalRoute.of(context)!.settings.arguments as UserModel?;
          return ReservationScreen(user: user ?? UserModel.defaultUser());
        },
      },
    );
  }
}


