part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {}

final class GetAllCartItemsEvent extends CartEvent {}

final class ToggleDeliveryEvent extends CartEvent {}

final class PayEvent extends CartEvent {
  final String cartId;
  final String pickupOrDelivery;
  final String? address;
  final String paymentMethod;
  final int? estimatedTime;
  PayEvent({required this.cartId, required this.pickupOrDelivery, this.address, required this.paymentMethod, this.estimatedTime});
}