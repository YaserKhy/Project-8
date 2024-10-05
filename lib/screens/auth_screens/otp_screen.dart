import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project8/constants/app_constants.dart';
import 'package:project8/extensions/screen_nav.dart';
import 'package:project8/extensions/screen_size.dart';
import 'package:project8/screens/auth_screens/bloc/auth_bloc.dart';
import 'package:project8/screens/navigation/user_navigation.dart';
import 'package:project8/widgets/other/auth_phrase.dart';
import 'package:project8/widgets/other/title_logo.dart';
import 'package:pinput/pinput.dart';
import 'package:otp_timer_button/otp_timer_button.dart';

class OtpScreen extends StatelessWidget {
  final String email;
  final String name;
  final String phoneNumber;
  const OtpScreen({super.key, required this.email, required this.name, required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    TextEditingController otpController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return BlocProvider(
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
                context.pushRemove(screen: const UserNavigation());
              }
            },
            child: GestureDetector(
              onTap: ()=> FocusManager.instance.primaryFocus?.unfocus(),
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                body: Stack(
                  children: [
                    Image.asset('assets/images/auth_bg.png', height: context.getHeight(), fit: BoxFit.cover),
                    Form(
                      key: formKey,
                      child: SingleChildScrollView(
                        child: Container(
                          width: context.getWidth(),
                          height: context.getHeight(),
                          color: AppConstants.authBgColor,
                          child: Column(
                            children: [
                              const SizedBox(height: 74,),
                              const TitleLogo(),
                              const SizedBox(height: 163,),
                              const Text("OTP VERIFICATION", style: TextStyle(fontSize: 20, fontFamily: "Average", fontWeight: FontWeight.w700, color: Colors.white)),
                              const SizedBox(height: 12,),
                              Text("Enter the OTP sent to - $email", style: const TextStyle(color: AppConstants.mainWhite, fontSize: 14),),
                              const SizedBox(height: 38),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                child: Pinput(
                                  length: 6,
                                  controller: otpController,
                                  onCompleted: (value) => bloc.add(VerifyOtpEvent(email:email,otp: value, name: name,role: "customer", phoneNumber: phoneNumber)),
                                  defaultPinTheme: PinTheme(
                                    width: 50,
                                    height: 50,
                                    margin: const EdgeInsets.symmetric(horizontal: 2),
                                    textStyle: const TextStyle(color: Colors.black, fontSize: 20, fontFamily: "Average"),
                                    decoration: BoxDecoration(
                                      color: AppConstants.mainWhite,
                                      border: Border.all(color: const Color(0xff282828).withOpacity(.5), width: .6),
                                      borderRadius: BorderRadius.circular(10)
                                    )
                                  ),
                                ),
                              ),
                              const SizedBox(height: 38),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text("Didn’t receive code ? ", style: TextStyle(color: AppConstants.mainWhite,fontFamily: "Average", fontSize: 15),),
                                  OtpTimerButton(
                                    onPressed: ()=>bloc.add(SendOtpEvent()),
                                    text: const Text("Re-send", style: TextStyle(fontFamily: "Average", color: AppConstants.mainRed, fontSize: 15, fontWeight: FontWeight.w700),),
                                    duration: 60,
                                    buttonType: ButtonType.text_button,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 170,),
                              const AuthPhrase()
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}