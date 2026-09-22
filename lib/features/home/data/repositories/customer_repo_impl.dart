import 'package:injectable/injectable.dart';
import 'package:task2shomewear/config/error_handling/result.dart';
import 'package:task2shomewear/features/home/api/data_source/local/customer_list_local_data_source_impl.dart';
import 'package:task2shomewear/features/home/data/data_source/customer_list_remote_data_source.dart';
import 'package:task2shomewear/features/home/data/data_source/local/customer_list_local_data_source.dart';
import 'package:task2shomewear/features/home/data/mapper/customer_model_mapper.dart';
import 'package:task2shomewear/features/home/data/model/response/update_customer_phone_response.dart';
import 'package:task2shomewear/features/home/domain/entities/customer_list_entity.dart';
import 'package:task2shomewear/features/home/domain/repositories/customer_repo.dart';

@Injectable(as: CustomerRepository)
class CustomerRepositoryImpl implements CustomerRepository {
  final CustomerListRemoteDataSource _remoteDataSource;
  final CustomerListLocalDataSource _localDataSource;

  CustomerRepositoryImpl(
      this._remoteDataSource,
      this._localDataSource,
      );

  /// Get Customers
  @override
  Future<Result<List<CustomerEntity>>> getCustomers({
    required String dbName,
    required int uid,
    required String password,
    String? searchQuery,
  }) async {
    final remoteResult =
    await _remoteDataSource.getCustomerList(
      dbName: dbName,
      uid: uid,
      password: password,
      searchQuery: searchQuery,
    );

    switch (remoteResult) {
      case Success(:final data):
        final entities = data.result
            ?.map((model) => model.toEntity())
            .toList() ??
            [];

        await _localDataSource.cacheCustomers(data);

        return Success(
          data: entities,
        );

      case Failure():
        final localResult =
        await _localDataSource.getCachedCustomers();

        switch (localResult) {
          case Success(:final data):
            final entities = data.result
                ?.map((model) => model.toEntity())
                .toList() ??
                [];

            return Success(
              data: entities,
            );

          case Failure():
            return Failure(
              errorMessage: remoteResult.errorMessage,
            );
        }
    }
  }

  /// Update Customer Phone
  @override
  Future<Result<bool>> updateCustomerPhone({
    required String dbName,
    required int uid,
    required String password,
    required int customerId,
    required String phone,
  }) async {
    final result =
    await _remoteDataSource.updateCustomerPhone(
      dbName: dbName,
      uid: uid,
      password: password,
      customerId: customerId,
      phone: phone,
    );

    switch (result) {
      case Success<UpdateCustomerPhoneResponse>():
        if (result.data.isSuccess) {
          return  Success(
            data: true,
          );
        }

        return  Failure(
          errorMessage:
          'Failed to update customer phone',
        );

      case Failure<UpdateCustomerPhoneResponse>():
        return Failure(
          errorMessage: result.errorMessage,
        );
    }
  }
}