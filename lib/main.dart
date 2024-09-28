import 'package:flutter/material.dart';
import 'package:project8/screens/user_screens/user_navigation.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: UserNavigation()
    );
  }
}
