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
