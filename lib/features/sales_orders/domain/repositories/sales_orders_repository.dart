

import 'package:task2shomewear/config/error_handling/result.dart';
import 'package:task2shomewear/features/sales_orders/domain/entities/sale_order_entity.dart';

abstract class SalesOrdersRepository {

  ///? Get Sale Orders
  Future<Result<List<SaleOrderEntity>>> getSaleOrders({
    required String dbName,
    required int uid,
    required String password,
  });

  ///?  Confirm Sale Order
  Future<Result<bool>> confirmSaleOrder({
    required String dbName,
    required int uid,
    required String password,
    required int orderId,
  });

  ///? Check Internal User
  Future<Result<bool>> checkInternalUser({
    required String dbName,
    required int uid,
    required String password,
  });
}