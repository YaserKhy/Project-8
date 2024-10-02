import 'dart:async';
import 'package:flutter/material.dart';
import 'package:project8/constants/app_constants.dart';
import 'package:project8/extensions/screen_nav.dart';
import 'package:project8/screens/navigation/user_navigation.dart';
import 'package:project8/screens/auth_screens/login_screen.dart';
import 'package:get_it/get_it.dart';
import 'package:project8/data_layers/auth_layer.dart';
import 'package:project8/widgets/other/title_logo.dart';

class SplachScreen extends StatefulWidget {
  const SplachScreen({super.key});

  @override
  _SplachScreenState createState() => _SplachScreenState();
}

class _SplachScreenState extends State<SplachScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 11,milliseconds: 400), () {
      bool isLoggedIn = GetIt.I.get<AuthLayer>().box.hasData("customer");
      if (isLoggedIn) {
        context.pushRemove(screen: const UserNavigation());
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(builder: (context) => const UserNavigation()),
        // );
      } else {
        context.pushRemove(screen: const LoginScreen());
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(builder: (context) => const LoginScreen()),
        // );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.mainBlue,
      body: Column(
        children: [
          const SizedBox(
            height: 74,
          ),
          const TitleLogo(),
          const SizedBox(
            height: 50,
          ),
          Expanded(
            child: Image.asset(
              'assets/images/splash_big_version.gif',
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
        ],
      ),
    );
  }
}
