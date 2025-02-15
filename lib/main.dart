import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fitboxing_app/services/auth_service.dart';
import 'package:fitboxing_app/screens/auth/login_screen.dart';
import 'package:fitboxing_app/screens/auth/signup_screen.dart';
import 'package:fitboxing_app/screens/dashboard/user_dashboard.dart';
import 'package:fitboxing_app/screens/dashboard/trainer_dashboard.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FitBoxing App',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignupScreen(),
        '/user_dashboard': (context) => UserDashboard(),
        '/trainer_dashboard': (context) => TrainerDashboard(),
      },
    );
  }
}
