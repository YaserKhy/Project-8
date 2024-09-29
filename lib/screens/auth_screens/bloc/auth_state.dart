part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class LoadingState extends AuthState {}

final class ErrorState extends AuthState {
  final String msg;
  ErrorState({required this.msg});
}

final class SuccessState extends AuthState {
  final String email;
  SuccessState({required this.email});
}