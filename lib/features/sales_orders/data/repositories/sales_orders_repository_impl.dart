import 'package:injectable/injectable.dart';

import 'package:task2shomewear/config/error_handling/result.dart';

import 'package:task2shomewear/features/sales_orders/data/data_source/sales_orders_remote_data_source.dart';
import 'package:task2shomewear/features/sales_orders/data/model/response/check_internal_user_response.dart';
import 'package:task2shomewear/features/sales_orders/data/model/response/confirm_sale_order_response.dart';
import 'package:task2shomewear/features/sales_orders/data/mapper/sale_order_mapper.dart';

import 'package:task2shomewear/features/sales_orders/domain/entities/sale_order_entity.dart';
import 'package:task2shomewear/features/sales_orders/domain/repositories/sales_orders_repository.dart';

@Injectable(as: SalesOrdersRepository)
class SalesOrdersRepositoryImpl
    implements SalesOrdersRepository {
  final SalesOrdersRemoteDataSource _remoteDataSource;

  SalesOrdersRepositoryImpl(
      this._remoteDataSource,
      );


  ///? Get Sale Orders
  @override
  Future<Result<List<SaleOrderEntity>>> getSaleOrders({
    required String dbName,
    required int uid,
    required String password,
  }) async {
    final result =
    await _remoteDataSource.getSaleOrders(
      dbName: dbName,
      uid: uid,
      password: password,
    );

    switch (result) {
      case Success(:final data):
        final orders = data.result
            ?.map((model) => model.toEntity())
            .toList() ??
            [];

        return Success(
          data: orders,
        );

      case Failure():
        return Failure(
          errorMessage: result.errorMessage,
        );
    }
  }


  ///?  Confirm Sale Order
  @override
  Future<Result<bool>> confirmSaleOrder({
    required String dbName,
    required int uid,
    required String password,
    required int orderId,
  }) async {
    final result =
    await _remoteDataSource.confirmSaleOrder(
      dbName: dbName,
      uid: uid,
      password: password,
      orderId: orderId,
    );

    switch (result) {
      case Success<ConfirmSaleOrderResponse>():
        if (result.data.isSuccess) {
          return  Success(
            data: true,
          );
        }

        return  Failure(
          errorMessage:
          'Failed to confirm sale order',
        );

      case Failure<ConfirmSaleOrderResponse>():
        return Failure(
          errorMessage: result.errorMessage,
        );
    }
  }

///? Check Internal User
  @override
  Future<Result<bool>> checkInternalUser({
    required String dbName,
    required int uid,
    required String password,
  }) async {
    final result =
    await _remoteDataSource.checkInternalUser(
      dbName: dbName,
      uid: uid,
      password: password,
    );

    switch (result) {
      case Success<CheckInternalUserResponse>():
        return Success(
          data: result.data.isInternalUser,
        );

      case Failure<CheckInternalUserResponse>():
        return Failure(
          errorMessage: result.errorMessage,
        );
    }
  }
}