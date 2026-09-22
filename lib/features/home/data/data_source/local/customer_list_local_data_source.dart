import 'package:task2shomewear/config/error_handling/result.dart';
import 'package:task2shomewear/features/home/data/model/response/customer_list_response.dart';

abstract class CustomerListLocalDataSource {
  Future<Result<void>> cacheCustomers(
      CustomerListResponse customers,
      );

  Future<Result<CustomerListResponse>> getCachedCustomers();

  Future<Result<void>> clearCachedCustomers();
}