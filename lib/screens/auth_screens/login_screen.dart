import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:project8/constants/app_constants.dart';
import 'package:project8/extensions/screen_nav.dart';
import 'package:project8/extensions/screen_size.dart';
import 'package:project8/screens/auth_screens/otp_screen.dart';
import 'package:project8/screens/auth_screens/sign_up_screen.dart';
import 'package:project8/widgets/fields/auth_field.dart';
import 'package:project8/widgets/buttons/auth_button.dart';
import 'package:project8/widgets/buttons/row_button.dart';
import 'package:project8/widgets/other/auth_phrase.dart';
import 'package:project8/widgets/other/title_logo.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController loginController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
          body: Stack(
          children: [
            // bg
            Image.asset('assets/images/auth_bg.png', height: context.getHeight(), fit: BoxFit.cover),
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
                      const SizedBox(height: 159,),
                      // form content
                      AuthField(title: "Email", controller: loginController),
                      const SizedBox(height: 94,),
                      // login button
                      AuthButton(
                        text: "Login",
                        onPressed: (){
                          if(formKey.currentState!.validate()) {
                            context.pushRemove(screen: OtpScreen(email: loginController.text,));
                          }
                        },
                      ),
                      // Row button "two texts, one of them is clickable"
                      RowButton(
                        text: "Don't have account ? ",
                        buttonText: "Sign up",
                        isBold: true,
                        onPressed: ()=> context.pushRemove(screen: const SignUpScreen())
                      ),
                      const SizedBox(height: 51,),
                      Stack(
                        children: [
                          // stars decoration around the row button
                          Image.asset('assets/images/guest_stars.png'),
                          Column(
                            children: [
                              SizedBox(
                                height: 30,
                                child: RowButton(
                                  text: "Continue as ",
                                  buttonText: "guest",
                                  isBold: true,
                                  onPressed: () => log("You Pressed guest"),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 87,),
                      // phrase in bottom left corner
                      const AuthPhrase()
                    ],
                  ),
                ),
              ),
            )
          ],
        )
      ),
    );
  }
}