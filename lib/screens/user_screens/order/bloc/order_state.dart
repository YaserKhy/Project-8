part of 'order_bloc.dart';

@immutable
sealed class OrderState {}

final class OrderInitial extends OrderState {}

final class ChangeIndcatorState extends OrderState {}

final class LoadingState extends OrderState {}

final class ErrorState extends OrderState {
  final String msg;
  ErrorState({required this.msg});
}

final class SuccessState extends OrderState {

}