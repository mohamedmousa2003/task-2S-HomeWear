import 'package:task2shomewear/config/error_handling/result.dart';
import 'package:task2shomewear/features/sales_orders/data/model/response/check_internal_user_response.dart';
import 'package:task2shomewear/features/sales_orders/data/model/response/confirm_sale_order_response.dart';
import 'package:task2shomewear/features/sales_orders/data/model/response/sale_order_response.dart';

abstract class SalesOrdersRemoteDataSource {

  ///? Get Sale Orders
  Future<Result<SaleOrderResponse>> getSaleOrders({
    required String dbName,
    required int uid,
    required String password,
  });

  ///?  Confirm Sale Order
  Future<Result<ConfirmSaleOrderResponse>> confirmSaleOrder({
    required String dbName,
    required int uid,
    required String password,
    required int orderId,
  });

  ///? Check Internal User
  Future<Result<CheckInternalUserResponse>>
  checkInternalUser({
    required String dbName,
    required int uid,
    required String password,
  });
}