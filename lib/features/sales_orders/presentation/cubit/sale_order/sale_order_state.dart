import 'package:equatable/equatable.dart';

import 'package:task2shomewear/features/sales_orders/domain/entities/sale_order_entity.dart';

sealed class SalesOrdersState extends Equatable {
  const SalesOrdersState();

  @override
  List<Object?> get props => [];
}

class SalesOrdersInitialState extends SalesOrdersState {
  const SalesOrdersInitialState();
}

class SalesOrdersLoadingState extends SalesOrdersState {
  const SalesOrdersLoadingState();
}

class SalesOrdersSuccessState extends SalesOrdersState {
  final List<SaleOrderEntity> orders;

  const SalesOrdersSuccessState(
      this.orders,
      );

  @override
  List<Object?> get props => [orders];
}

class SalesOrdersErrorState extends SalesOrdersState {
  final String message;

  const SalesOrdersErrorState(
      this.message,
      );

  @override
  List<Object?> get props => [message];
}

class SaleOrderConfirmingState extends SalesOrdersState {
  const SaleOrderConfirmingState();
}

class SaleOrderConfirmedState extends SalesOrdersState {
  const SaleOrderConfirmedState();
}

class SaleOrderConfirmFailureState extends SalesOrdersState {
  final String message;

  const SaleOrderConfirmFailureState(
      this.message,
      );

  @override
  List<Object?> get props => [message];
}