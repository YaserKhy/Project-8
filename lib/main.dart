import 'package:flutter/material.dart';
import 'package:project8/screens/auth_screens/login_screen.dart';
// import 'package:project8/screens/user_screens/user_navigation.dart';
import 'package:project8/services/setup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setup();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginScreen()
    );
  }
}
