import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:task2shomewear/features/home/data/model/request/customer_list_request.dart';
import 'package:task2shomewear/features/home/data/model/request/update_customer_phone_request.dart';
import 'package:task2shomewear/features/home/data/model/response/customer_list_response.dart';
import 'package:task2shomewear/features/home/data/model/response/update_customer_phone_response.dart';
import '../../../core/values/api_end_points.dart';

part 'api_client_home.g.dart';

@injectable
@RestApi()
abstract class ApiClientHome {
  @factoryMethod
  factory ApiClientHome(Dio dio) = _ApiClientHome;

  @POST(ApiEndPoints.baseUrl)
  Future<CustomerListResponse> getCustomerList(
      @Body() CustomerListRequest customerList,
  );

  ///? Update Customer Phone
  @POST(ApiEndPoints.baseUrl)
  Future<UpdateCustomerPhoneResponse> updateCustomerPhone(
      @Body() UpdateCustomerPhoneRequest request,
      );
}