part of 'favorite_bloc.dart';

@immutable
sealed class FavoriteEvent {}

final class GetFavItemsEvent extends FavoriteEvent {}