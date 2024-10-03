part of 'view_item_bloc.dart';

@immutable
sealed class ViewItemEvent {}

class IncreaseQuantityEvent extends ViewItemEvent {
  final int quantity;
  IncreaseQuantityEvent({required this.quantity});
}

class DecreaseQuantityEvent extends ViewItemEvent {
  final int quantity;
  DecreaseQuantityEvent({required this.quantity});
}
