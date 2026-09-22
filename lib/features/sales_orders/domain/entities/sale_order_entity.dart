import 'package:equatable/equatable.dart';
import 'package:task2shomewear/features/sales_orders/domain/entities/sale_order_line_entity.dart';

class SaleOrderEntity extends Equatable {
  final int id;
  final String orderNumber;
  final String customerName;
  final String orderDate;
  final String status;
  final double total;
  final List<SaleOrderLineEntity> products;


  const SaleOrderEntity({
    required this.id,
    required this.orderNumber,
    required this.customerName,
    required this.orderDate,
    required this.status,
    required this.total,
    required this.products,
  });

  @override
  List<Object?> get props => [
    id,
    orderNumber,
    customerName,
    orderDate,
    status,
    total,
    products,

  ];
}