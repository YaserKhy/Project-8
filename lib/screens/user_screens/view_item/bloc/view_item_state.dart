part of 'view_item_bloc.dart';

@immutable
sealed class ViewItemState {}

final class ViewItemInitial extends ViewItemState {}

final class UpdateQuantityState extends ViewItemState {
  final int quantity;
  UpdateQuantityState({required this.quantity});
}
