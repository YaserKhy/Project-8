part of 'favorite_bloc.dart';

@immutable
sealed class FavoriteEvent {}

final class GetFavItemsEvent extends FavoriteEvent {}

class ToggleFavoriteEvent extends FavoriteEvent {
  final ItemModel item;
  ToggleFavoriteEvent({required this.item});
}