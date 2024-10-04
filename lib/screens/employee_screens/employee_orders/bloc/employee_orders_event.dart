part of 'employee_orders_bloc.dart';

@immutable
sealed class EmployeeOrdersEvent {}

final class ChangeIndcatorEvent extends EmployeeOrdersEvent {}

final class GetOrdersEvent extends EmployeeOrdersEvent {}

final class GAGA extends EmployeeOrdersEvent {
  final String cartId;
  GAGA({required this.cartId});
}
