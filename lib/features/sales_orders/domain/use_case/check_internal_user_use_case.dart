import 'package:injectable/injectable.dart';
import 'package:task2shomewear/config/error_handling/result.dart';
import 'package:task2shomewear/features/sales_orders/domain/repositories/sales_orders_repository.dart';

@injectable
class CheckInternalUserUseCase {
  final SalesOrdersRepository _repository;

  CheckInternalUserUseCase(
      this._repository,
      );

  Future<Result<bool>> call({
    required String dbName,
    required int uid,
    required String password,
  }) {
    return _repository.checkInternalUser(
      dbName: dbName,
      uid: uid,
      password: password,
    );
  }
}