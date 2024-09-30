part of 'page_bloc.dart';

@immutable
sealed class PageState {}

final class PageInitial extends PageState {}

final class ShowState extends PageState {
  final int index;
  ShowState({required this.index});
}