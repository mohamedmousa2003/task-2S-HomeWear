import 'package:injectable/injectable.dart';
import 'package:task2shomewear/config/error_handling/execute_api.dart';
import 'package:task2shomewear/config/error_handling/result.dart';
import 'package:task2shomewear/features/home/api/api_client_home.dart';
import 'package:task2shomewear/features/home/data/data_source/customer_list_remote_data_source.dart';
import 'package:task2shomewear/features/home/data/model/request/customer_list_request.dart';
import 'package:task2shomewear/features/home/data/model/request/update_customer_phone_request.dart';
import 'package:task2shomewear/features/home/data/model/response/customer_list_response.dart';
import 'package:task2shomewear/features/home/data/model/response/update_customer_phone_response.dart';

@Injectable(as: CustomerListRemoteDataSource)
class CustomerListRemoteDataSourceImpl
    implements CustomerListRemoteDataSource {
  final ApiClientHome _apiClientHome;

  CustomerListRemoteDataSourceImpl(this._apiClientHome);


  ///? Get Customer List
  @override
  Future<Result<CustomerListResponse>> getCustomerList({
    required String dbName,
    required int uid,
    required String password,
    String? searchQuery,
  }) {
    final domain = [
      ["customer_rank", ">=", 0],
      if (searchQuery != null && searchQuery.trim().isNotEmpty)
        ["name", "ilike", searchQuery.trim()],
    ];

    final kwargs = {
      "fields": ["id", "name", "phone", "city","email"],
      "limit": 50,
    };

    return executeApi<CustomerListResponse>(() async {
      final response = await _apiClientHome.getCustomerList(
        CustomerListRequest(
          params: Params(
            args: [
              dbName,
              uid,
              password,
              "res.partner",
              "search_read",
              [domain],
              kwargs,
            ],
          ),
        ),
      );

      return response;
    });
  }


  ///? Update Customer Phone
  @override
  Future<Result<UpdateCustomerPhoneResponse>> updateCustomerPhone({
    required String dbName,
    required int uid,
    required String password,
    required int customerId,
    required String phone,
  }) {
    return executeApi<UpdateCustomerPhoneResponse>(() async {
      final response = await _apiClientHome.updateCustomerPhone(
        UpdateCustomerPhoneRequest(
          params: UpdatePhoneParams(
            args: [
              dbName,
              uid,
              password,
              "res.partner",
              "write",
              [
                [customerId],
                {
                  "phone": phone,
                },
              ],
            ],
          ),
        ),
      );

      return response;
    });
  }
}