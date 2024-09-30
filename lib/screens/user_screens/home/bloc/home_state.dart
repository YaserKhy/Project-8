part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class LoadingState extends HomeState {}

final class SuccessState extends HomeState {
  final String selectedCategory;
  final List<ItemModel> items;
  final List<ItemModel> favorites;

  SuccessState({
    required this.selectedCategory,
    required this.items,
    required this.favorites,
  });
}

final class ErrorState extends HomeState {
  final String msg;
  ErrorState({required this.msg});
}


class FavoriteUpdatedState extends HomeState {
  final List<ItemModel> favorites;

  FavoriteUpdatedState({required this.favorites});

  @override
  List<Object> get props => [favorites];
}

