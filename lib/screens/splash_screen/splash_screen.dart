import 'dart:async';
import 'package:flutter/material.dart';
import 'package:project8/constants/app_constants.dart';
import 'package:project8/extensions/screen_nav.dart';
import 'package:project8/screens/navigation/user_navigation.dart';
import 'package:project8/screens/auth_screens/login_screen.dart';
import 'package:get_it/get_it.dart';
import 'package:project8/data_layers/auth_layer.dart';
import 'package:project8/widgets/other/title_logo.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  void _navigate(BuildContext context) {
    Future.delayed(const Duration(seconds: 2, milliseconds: 800), () {
      bool isLoggedIn = GetIt.I.get<AuthLayer>().box.hasData("customer");
      if (isLoggedIn) {
        context.pushRemove(screen: const UserNavigation());
      } else {
        context.pushRemove(screen: const LoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _navigate(context);
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
              'assets/images/one second splach.gif',
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
        ],
      ),
    );
  }
}
