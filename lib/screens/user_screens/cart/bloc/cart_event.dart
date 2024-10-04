part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {}

final class GetAllCartItemsEvent extends CartEvent {}

final class IncreaseQuantityEvent extends CartEvent {
  final int itemId;
  IncreaseQuantityEvent(this.itemId);
}

final class DecreaseQuantityEvent extends CartEvent {
  final int itemId;
  DecreaseQuantityEvent(this.itemId);
}

final class PayEvent extends CartEvent {
  final String cartId;
  final String pickupOrDelivery;
  final String? address;
  final String paymentMethod;
  final int? estimatedTime;
  PayEvent({required this.cartId, required this.pickupOrDelivery, this.address, required this.paymentMethod, this.estimatedTime});
}