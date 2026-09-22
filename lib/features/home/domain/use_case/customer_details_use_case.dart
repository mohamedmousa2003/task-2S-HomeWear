import 'package:injectable/injectable.dart';
import 'package:task2shomewear/config/error_handling/result.dart';
import 'package:task2shomewear/features/home/domain/entities/customer_list_entity.dart';
import 'package:task2shomewear/features/home/domain/repositories/customer_repo.dart';

@injectable
class GetCustomersUseCase {
  final CustomerRepository _repository;

  GetCustomersUseCase(this._repository);

  Future<Result<List<CustomerEntity>>> call({
    required String dbName,
    required int uid,
    required String password,
    String? searchQuery,
  }) {
    return _repository.getCustomers(
      dbName: dbName,
      uid: uid,
      password: password,
      searchQuery: searchQuery,
    );
  }
}