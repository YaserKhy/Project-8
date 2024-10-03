part of 'view_item_bloc.dart';

@immutable
sealed class ViewItemEvent {}

class ToggleFavoriteEvent extends ViewItemEvent {
  final ItemModel item;
  ToggleFavoriteEvent({required this.item});
}
