part of 'view_item_bloc.dart';

@immutable
sealed class ViewItemState {}

final class ViewItemInitial extends ViewItemState {}

final class LoadingState extends ViewItemState {}

final class SuccessState extends ViewItemState {}

final class ErrorState extends ViewItemState {
  final String msg;
  ErrorState({required this.msg});
}
