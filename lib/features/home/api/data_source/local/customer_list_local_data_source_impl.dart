import 'dart:convert';
import 'package:hive_ce/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:task2shomewear/config/error_handling/result.dart';
import 'package:task2shomewear/features/home/data/data_source/local/customer_list_local_data_source.dart';
import 'package:task2shomewear/features/home/data/model/response/customer_list_response.dart';

@Injectable(as: CustomerListLocalDataSource)
class CustomerListLocalDataSourceImpl
    implements CustomerListLocalDataSource {

  static const String _boxName = 'customers_box';
  static const String _customersKey = 'customers';

  @override
  Future<Result<void>> cacheCustomers(
      CustomerListResponse customers,
      ) async {
    try {
      final box = await Hive.openBox<String>(_boxName);

      await box.put(
        _customersKey,
        jsonEncode(customers.toJson()),
      );

      return  Success(data: null);
    } catch (e) {
      return Failure(
        errorMessage: e.toString(),
      );
    }
  }

  @override
  Future<Result<CustomerListResponse>> getCachedCustomers() async {
    try {
      final box = await Hive.openBox<String>(_boxName);

      final cachedData = box.get(_customersKey);

      if (cachedData == null) {
        return Failure(
          errorMessage: 'No cached customers found',
        );
      }

      final Map<String, dynamic> jsonData =
      jsonDecode(cachedData);

      final customers =
      CustomerListResponse.fromJson(jsonData);

      return Success(
        data: customers,
      );
    } catch (e) {
      return Failure(
        errorMessage: e.toString(),
      );
    }
  }

  @override
  Future<Result<void>> clearCachedCustomers() async {
    try {
      final box = await Hive.openBox<String>(_boxName);

      await box.delete(_customersKey);

      return Success(data: null);
    } catch (e) {
      return Failure(
        errorMessage: e.toString(),
      );
    }
  }
}