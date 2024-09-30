part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

final class GetAllItemsEvent extends HomeEvent {}

final class ChangeCategoryEvent extends HomeEvent {
  final String category;
  ChangeCategoryEvent({required this.category});
}

class ToggleFavoriteEvent extends HomeEvent {
  final ItemModel item;
  ToggleFavoriteEvent({required this.item});

  @override
  List<Object> get props => [item];
}
