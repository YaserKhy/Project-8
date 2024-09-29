import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:project8/constants/app_constants.dart';
import 'package:project8/data_layers/auth_layer.dart';
import 'package:project8/extensions/screen_nav.dart';
import 'package:project8/screens/auth_screens/login_screen.dart';
import 'package:project8/widgets/other/page_title.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.mainBgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const PageTitle(title: "Profile"),
              const SizedBox(height: 50,),
              ElevatedButton(onPressed: (){
                log("bye bye");
                GetIt.I.get<AuthLayer>().customer = null;
                GetIt.I.get<AuthLayer>().box.erase();
                log("box now is empty");
                context.pushRemove(screen: const LoginScreen());
              }, child: const Text("logout"))
            ],
          ),
        ),
      ),
    );
  }
}