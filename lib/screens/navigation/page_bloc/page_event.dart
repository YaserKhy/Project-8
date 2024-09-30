part of 'page_bloc.dart';

@immutable
sealed class PageEvent {}

final class ChangePageEvent extends PageEvent {
  final int index;
  ChangePageEvent({required this.index});
}