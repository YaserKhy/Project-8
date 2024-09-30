part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class CreateAccountEvent extends AuthEvent {
  final String email;
  final String password;
  final String name;
  CreateAccountEvent({required this.email,required this.password, required this.name});
}

final class LoginEvent extends AuthEvent {
  final String email;
  final String password;
  LoginEvent({required this.email, required this.password});
}

final class SendOtpEvent extends AuthEvent {}

final class VerifyOtpEvent extends AuthEvent {
  final String otp;
  final String email;
  final String name;
  final String phoneNumber;
  VerifyOtpEvent({required this.email,required this.name,required this.phoneNumber,required this.otp});
}