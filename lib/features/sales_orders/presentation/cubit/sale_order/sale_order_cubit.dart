import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:task2shomewear/config/error_handling/result.dart';
import 'package:task2shomewear/features/sales_orders/domain/use_case/confirm_sale_order_use_case.dart';
import 'package:task2shomewear/features/sales_orders/domain/use_case/get_sale_orders_use_case.dart';
import 'package:task2shomewear/features/sales_orders/presentation/cubit/sale_order/sale_order_state.dart';


@injectable
class SalesOrdersCubit extends Cubit<SalesOrdersState> {
  final GetSaleOrdersUseCase _getSaleOrdersUseCase;
  final ConfirmSaleOrderUseCase _confirmSaleOrderUseCase;

  SalesOrdersCubit(
      this._getSaleOrdersUseCase,
      this._confirmSaleOrderUseCase,
      ) : super(
    const SalesOrdersInitialState(),
  );

  Future<void> fetchSaleOrders({
    required String dbName,
    required int uid,
    required String password,
  }) async {
    emit(
      const SalesOrdersLoadingState(),
    );

    final result = await _getSaleOrdersUseCase(
      dbName: dbName,
      uid: uid,
      password: password,
    );

    switch (result) {
      case Success(:final data):
        emit(
          SalesOrdersSuccessState(data),
        );

      case Failure(:final errorMessage):
        emit(
          SalesOrdersErrorState(errorMessage),
        );
    }
  }

  Future<bool> confirmSaleOrder({
    required String dbName,
    required int uid,
    required String password,
    required int orderId,
  }) async {
    emit(
      const SaleOrderConfirmingState(),
    );

    final result = await _confirmSaleOrderUseCase(
      dbName: dbName,
      uid: uid,
      password: password,
      orderId: orderId,
    );

    switch (result) {
      case Success():
        emit(
          const SaleOrderConfirmedState(),
        );

        return true;

      case Failure(:final errorMessage):
        emit(
          SaleOrderConfirmFailureState(
            errorMessage,
          ),
        );

        return false;
    }
  }
}