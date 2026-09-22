import 'package:injectable/injectable.dart';

import 'package:task2shomewear/config/error_handling/result.dart';
import 'package:task2shomewear/config/error_handling/execute_api.dart';

import 'package:task2shomewear/features/sales_orders/api/api_client_sales_orders.dart';

import 'package:task2shomewear/features/sales_orders/data/data_source/sales_orders_remote_data_source.dart';
import 'package:task2shomewear/features/sales_orders/data/model/request/check_internal_user_request.dart';

import 'package:task2shomewear/features/sales_orders/data/model/request/confirm_sale_order_request.dart';
import 'package:task2shomewear/features/sales_orders/data/model/request/sale_order_request.dart';
import 'package:task2shomewear/features/sales_orders/data/model/response/check_internal_user_response.dart';

import 'package:task2shomewear/features/sales_orders/data/model/response/confirm_sale_order_response.dart';
import 'package:task2shomewear/features/sales_orders/data/model/response/sale_order_response.dart';

@Injectable(as: SalesOrdersRemoteDataSource)
class SalesOrdersRemoteDataSourceImpl
    implements SalesOrdersRemoteDataSource {
  final ApiClientSalesOrders _apiClient;

  SalesOrdersRemoteDataSourceImpl(
      this._apiClient,
      );


  ///? Get Sale Orders
  @override
  Future<Result<SaleOrderResponse>> getSaleOrders({
    required String dbName,
    required int uid,
    required String password,
  }) {
    return executeApi<SaleOrderResponse>(() async {
      return _apiClient.getSaleOrders(
        SaleOrderRequest(
          params: SaleOrderParams(
            args: [
              dbName,
              uid,
              password,
              'sale.order',
              'search_read',
              [
                [],
              ],
              {
                'fields': [
                  'id',
                  'name',
                  'partner_id',
                  'date_order',
                  'state',
                  'amount_total',
                ],
                'limit': 50,
                'order': 'date_order desc',
              },
            ],
          ),
        ),
      );
    });
  }

  ///?  Confirm Sale Order
  @override
  Future<Result<ConfirmSaleOrderResponse>> confirmSaleOrder({
    required String dbName,
    required int uid,
    required String password,
    required int orderId,
  }) {
    return executeApi<ConfirmSaleOrderResponse>(() async {
      return _apiClient.confirmSaleOrder(
        ConfirmSaleOrderRequest(
          params: ConfirmSaleOrderParams(
            args: [
              dbName,
              uid,
              password,
              'sale.order',
              'action_confirm',
              [
                [orderId],
              ],
            ],
          ),
        ),
      );
    });
  }

///? Check Internal User
  @override
  Future<Result<CheckInternalUserResponse>>
  checkInternalUser({
    required String dbName,
    required int uid,
    required String password,
  }) {
    return executeApi<CheckInternalUserResponse>(
          () async {
        return _apiClient.checkInternalUser(
          CheckInternalUserRequest(
            params: CheckInternalUserParams(
              args: [
                dbName,
                uid,
                password,
                'res.users',
                'has_group',
                [
                  'base.group_user',
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}