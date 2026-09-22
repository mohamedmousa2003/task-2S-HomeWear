import 'package:injectable/injectable.dart';

import 'package:task2shomewear/config/error_handling/result.dart';
import 'package:task2shomewear/features/sales_orders/domain/entities/sale_order_entity.dart';
import 'package:task2shomewear/features/sales_orders/domain/repositories/sales_orders_repository.dart';

@injectable
class GetSaleOrdersUseCase {
  final SalesOrdersRepository _repository;

  GetSaleOrdersUseCase(
      this._repository,
      );

  Future<Result<List<SaleOrderEntity>>> call({
    required String dbName,
    required int uid,
    required String password,
  }) {
    return _repository.getSaleOrders(
      dbName: dbName,
      uid: uid,
      password: password,
    );
  }
}