import 'package:task2shomewear/config/error_handling/result.dart';
import 'package:task2shomewear/features/home/data/model/response/customer_list_response.dart';
import 'package:task2shomewear/features/home/data/model/response/update_customer_phone_response.dart';

abstract class CustomerListRemoteDataSource {
  ///? Get Customer List
  Future<Result<CustomerListResponse>> getCustomerList({
    required String dbName,
    required int uid,
    required String password,
    String? searchQuery,
  });

  ///? Update Customer Phone
  Future<Result<UpdateCustomerPhoneResponse>> updateCustomerPhone({
    required String dbName,
    required int uid,
    required String password,
    required int customerId,
    required String phone,
  });
}