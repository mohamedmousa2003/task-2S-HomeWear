import 'package:equatable/equatable.dart';

class SaleOrderLineEntity extends Equatable {
  final int id;
  final String productName;
  final double quantity;
  final double unitPrice;
  final double subtotal;

  const SaleOrderLineEntity({
    required this.id,
    required this.productName,
    required this.quantity,
    required this.unitPrice,
    required this.subtotal,
  });

  @override
  List<Object?> get props => [
    id,
    productName,
    quantity,
    unitPrice,
    subtotal,
  ];
}