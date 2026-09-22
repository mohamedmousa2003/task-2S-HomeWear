import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:task2shomewear/core/values/api_end_points.dart';
import 'package:task2shomewear/features/sales_orders/data/model/request/check_internal_user_request.dart';
import 'package:task2shomewear/features/sales_orders/data/model/request/confirm_sale_order_request.dart';
import 'package:task2shomewear/features/sales_orders/data/model/request/sale_order_request.dart';
import 'package:task2shomewear/features/sales_orders/data/model/response/check_internal_user_response.dart';
import 'package:task2shomewear/features/sales_orders/data/model/response/confirm_sale_order_response.dart';
import 'package:task2shomewear/features/sales_orders/data/model/response/sale_order_response.dart';
part 'api_client_sales_orders.g.dart';
@injectable
@RestApi()
abstract class ApiClientSalesOrders {
  @factoryMethod
  factory ApiClientSalesOrders(Dio dio) =
  _ApiClientSalesOrders;

  @POST(ApiEndPoints.baseUrl)
  Future<SaleOrderResponse> getSaleOrders(
      @Body() SaleOrderRequest request,
      );

  ///? Confirm Sale Order
  @POST(ApiEndPoints.baseUrl)
  Future<ConfirmSaleOrderResponse> confirmSaleOrder(
      @Body() ConfirmSaleOrderRequest request,
      );

  ///? Check Internal User
  @POST(ApiEndPoints.baseUrl)
  Future<CheckInternalUserResponse> checkInternalUser(
      @Body() CheckInternalUserRequest request,
      );
}