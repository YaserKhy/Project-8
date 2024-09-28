import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:project8/constants/app_constants.dart';
import 'package:project8/extensions/screen_nav.dart';
import 'package:project8/extensions/screen_size.dart';
import 'package:project8/screens/auth_screens/login_screen.dart';
import 'package:project8/widgets/buttons/auth_button.dart';
import 'package:project8/widgets/buttons/row_button.dart';
import 'package:project8/widgets/fields/auth_field.dart';
import 'package:project8/widgets/other/auth_phrase.dart';
import 'package:project8/widgets/other/title_logo.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            // bg
            Image.asset('assets/images/auth_bg.png', height: context.getHeight(),fit: BoxFit.cover),
            // page content
            Form(
              key: formKey,
              child: SingleChildScrollView(
                // container only for color opacity
                child: Container(
                  width: context.getWidth(),
                  height: context.getHeight(),
                  color: AppConstants.authBgColor,
                  child: Column(
                    children: [
                      const SizedBox(height: 74,),
                      // title logo
                      const TitleLogo(),
                      const SizedBox(height: 119,),
                      // form content
                      AuthField(title: "Email", controller: emailController),
                      const SizedBox(height: 25,),
                      AuthField(title: "Name", controller: nameController),
                      const SizedBox(height: 63),
                      AuthButton(text: "Create Account", onPressed: () => log("message")),
                      RowButton(
                        onPressed: () => context.pushRemove(screen: const LoginScreen()),
                        text: "Have Account? ",
                        buttonText: "Login",
                        isBold: true
                      ),
                      const SizedBox(height: 116),
                      const AuthPhrase()
                    ],
                  ),
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}