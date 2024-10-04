part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {}

final class GetAllCartItemsEvent extends CartEvent {}


final class PayEvent extends CartEvent {
  final String cartId;
  PayEvent({required this.cartId});
}