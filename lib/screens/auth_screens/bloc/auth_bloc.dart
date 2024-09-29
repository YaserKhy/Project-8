import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:project8/data_layers/supabase_layer.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController loginController = TextEditingController();
  TextEditingController loginPassController = TextEditingController();
  final supabase = GetIt.I.get<SupabaseLayer>();
  AuthBloc() : super(AuthInitial()) {
    on<CreateAccountEvent>((event, emit) async {
      try {
        emit(LoadingState());
        await supabase.createAccount(email: event.email,password: event.password);
        log("check your email !!");
        emit(SuccessState(email: event.email));
      } catch (e) {
        emit(ErrorState(msg: e.toString()));
      }
    });

    on<LoginEvent>((event, emit) async {
      try {
        emit(LoadingState());
        await supabase.login(email: event.email,password: event.password);
        log("Signing in !!");
        emit(SuccessState(email: event.email));
      } catch (e) {
        emit(ErrorState(msg: e.toString()));
      }
    });

    on<VerifyOtpEvent>((event, emit) async {
      try {
        emit(LoadingState());
        await supabase.verifyOtp(email: event.email,otp: event.otp, name: event.name, phoneNumber: event.phoneNumber);
        emit(SuccessState(email: event.email));
      } catch (e) {
        emit(ErrorState(msg: e.toString()));
      }
    });
  }
}