part of 'cart_bloc.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

final class LoadingState extends CartState {}

final class ToggleDeliveryState extends CartState {
  final bool isDelivery;
  ToggleDeliveryState({required this.isDelivery});
}

final class SuccessState extends CartState {
  final CartModel? cart;
  SuccessState({this.cart});
}

final class ErrorState extends CartState {
  final String msg;
  ErrorState({required this.msg});
}

