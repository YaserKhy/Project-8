part of 'order_bloc.dart';

@immutable
sealed class OrderEvent {}

final class ChangeIndcatorEvent extends OrderEvent {}

final class GetOrdersEvent extends OrderEvent {}

final class GAGA extends OrderEvent {
  final String cartId;
  GAGA({required this.cartId});
}