import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project8/constants/app_constants.dart';
import 'package:project8/extensions/screen_nav.dart';
import 'package:project8/extensions/screen_size.dart';
import 'package:project8/screens/auth_screens/bloc/auth_bloc.dart';
import 'package:project8/screens/auth_screens/sign_up_screen.dart';
import 'package:project8/screens/navigation/user_navigation.dart';
import 'package:project8/widgets/fields/auth_field.dart';
import 'package:project8/widgets/buttons/auth_button.dart';
import 'package:project8/widgets/buttons/row_button.dart';
import 'package:project8/widgets/other/auth_phrase.dart';
import 'package:project8/widgets/other/title_logo.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: Builder(builder: (context) {
        final bloc = context.read<AuthBloc>();
        return BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if(state is LoadingState) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context)=>const Center(child: CircularProgressIndicator())
              );
            }
            if(state is ErrorState) {
              context.pop();
              showDialog(
                context: context,
                builder: (context)=>AlertDialog(
                  content: Column(
                    children: [
                      const Icon(Icons.error_outline, color: AppConstants.mainRed,),
                      const SizedBox(height: 10,),
                      Text("Error : ${state.msg}")
                    ],
                  ),
                )
              );
            }
            if(state is SuccessState) {
              context.pushRemove(screen: const UserNavigation());
            }
          },
          child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: Stack(
                children: [
                  // bg
                  Image.asset('assets/images/auth_bg.png',height: context.getHeight(), fit: BoxFit.cover),
                  // page content
                  Form(
                    key: formKey,
                    child: Container(
                      width: context.getWidth(),
                      height: context.getHeight(),
                      color: AppConstants.authBgColor,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(height: 74,),
                            // title logo
                            const TitleLogo(),
                            const SizedBox(height: 80,),
                            // form content
                            AuthField(title: "Email", controller: bloc.loginController),
                            const SizedBox(height: 25,),
                            AuthField(title: "Password",controller: bloc.loginPassController),
                            const SizedBox(height: 80,),
                            // login button
                            AuthButton(
                              text: "Login",
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  bloc.add(LoginEvent(
                                    email: bloc.loginController.text,
                                    password: bloc.loginPassController.text
                                  ));
                                }
                              },
                            ),
                            // Row button "two texts, one of them is clickable"
                            RowButton(
                              text: "Don't have account ? ",
                              buttonText: "Sign up",
                              isBold: true,
                              onPressed: () => context.pushRemove(screen: const SignUpScreen())
                            ),
                            const SizedBox(height: 51),
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
                          ],
                        ),
                      ),
                    ),
                  ),
                  // phrase in bottom left corner
                  const Positioned(bottom: 35, child: AuthPhrase())
                ],
              )
            ),
          ),
        );
      }),
    );
  }
}
