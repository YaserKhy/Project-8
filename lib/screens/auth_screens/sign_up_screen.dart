import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project8/constants/app_constants.dart';
import 'package:project8/extensions/screen_nav.dart';
import 'package:project8/extensions/screen_size.dart';
import 'package:project8/screens/auth_screens/bloc/auth_bloc.dart';
import 'package:project8/screens/auth_screens/login_screen.dart';
import 'package:project8/screens/auth_screens/otp_screen.dart';
import 'package:project8/widgets/buttons/auth_button.dart';
import 'package:project8/widgets/buttons/row_button.dart';
import 'package:project8/widgets/fields/auth_field.dart';
import 'package:project8/widgets/other/auth_phrase.dart';
import 'package:project8/widgets/other/title_logo.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: BlocProvider(
        create: (context) => AuthBloc(),
        child: Builder(
          builder: (context) {
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
                  context.pushRemove(screen: OtpScreen(email: state.email, name: bloc.nameController.text, phoneNumber: bloc.phoneController.text,));
                }
              },
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                body: Stack(
                  children: [
                    // bg
                    Image.asset('assets/images/auth_bg.png',height: context.getHeight(), fit: BoxFit.cover),
                    // page content
                    Form(
                      key: formKey,
                      child: SingleChildScrollView(
                        // container only for color opacity
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
                                const SizedBox(height: 30,),
                                // form content
                                AuthField(title: "Email", controller: bloc.emailController),
                                const SizedBox(height: 12,),
                                AuthField(title: "Password", controller: bloc.passController),
                                const SizedBox(height: 12,),
                                AuthField(title: "Name", controller: bloc.nameController),
                                const SizedBox(height: 12,),
                                AuthField(title: "Phone Number",controller: bloc.phoneController),
                                const SizedBox(height: 30),
                                AuthButton(
                                  text: "Create Account",
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      bloc.add(
                                        CreateAccountEvent(
                                          email: bloc.emailController.text,
                                          name: bloc.nameController.text,
                                          password: bloc.passController.text,
                                        )
                                      );
                                    }
                                  }
                                ),
                                RowButton(
                                  onPressed: () => context.pushRemove(screen: const LoginScreen()),
                                  text: "Have Account? ",
                                  buttonText: "Login",
                                  isBold: true
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ),
                    const Positioned(bottom: 35,child: AuthPhrase())
                  ],
                ),
              ),
            );
          }
        ),
      ),
    );
  }
}