import 'package:task2shomewear/config/error_handling/result.dart';
import 'package:task2shomewear/features/home/domain/entities/customer_list_entity.dart';

abstract class CustomerRepository {
  ///? Get Customers
  Future<Result<List<CustomerEntity>>> getCustomers({
    required String dbName,
    required int uid,
    required String password,
    String? searchQuery,
  });


 ///? Update Customer Phone
  Future<Result<bool>> updateCustomerPhone({
    required String dbName,
    required int uid,
    required String password,
    required int customerId,
    required String phone,
  });
}