part of 'favorite_bloc.dart';

@immutable
sealed class FavoriteState {}

final class FavoriteInitial extends FavoriteState {}

final class LoadingState extends FavoriteState {}

final class SuccessState extends FavoriteState {
  final List favList;
  SuccessState({required this.favList});
}

final class ErrorState extends FavoriteState {
  final String msg;
  ErrorState({required this.msg});
}

