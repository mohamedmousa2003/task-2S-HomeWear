import 'package:injectable/injectable.dart';

import 'package:task2shomewear/config/error_handling/result.dart';

import 'package:task2shomewear/features/home/domain/repositories/customer_repo.dart';

@injectable
class UpdateCustomerPhoneUseCase {
  final CustomerRepository _repository;

  UpdateCustomerPhoneUseCase(this._repository);

  Future<Result<bool>> call({
    required String dbName,
    required int uid,
    required String password,
    required int customerId,
    required String phone,
  }) {
    return _repository.updateCustomerPhone(
      dbName: dbName,
      uid: uid,
      password: password,
      customerId: customerId,
      phone: phone,
    );
  }
}