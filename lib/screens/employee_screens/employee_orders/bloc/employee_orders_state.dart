part of 'employee_orders_bloc.dart';

@immutable
sealed class EmployeeOrdersState {}

final class EmployeeOrdersInitial extends EmployeeOrdersState {}

final class OrderInitial extends EmployeeOrdersState {}

final class ChangeIndcatorState extends EmployeeOrdersState {}

final class LoadingState extends EmployeeOrdersState {}

final class ErrorState extends EmployeeOrdersState {
  final String msg;
  ErrorState({required this.msg});
}

final class SuccessState extends EmployeeOrdersState {}
