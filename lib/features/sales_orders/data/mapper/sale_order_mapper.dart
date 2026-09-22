import 'package:task2shomewear/features/sales_orders/data/model/request/sale_order_line_model.dart';
import 'package:task2shomewear/features/sales_orders/data/model/response/sale_order_model.dart';
import 'package:task2shomewear/features/sales_orders/domain/entities/sale_order_entity.dart';
import 'package:task2shomewear/features/sales_orders/domain/entities/sale_order_line_entity.dart';

extension SaleOrderModelMapper on SaleOrderModel {
  SaleOrderEntity toEntity() {
    String customerName = 'Not Available';

    if (partnerId is List && partnerId.length > 1) {
      customerName =
          partnerId[1]?.toString() ?? 'Not Available';
    }

    return SaleOrderEntity(
      id: id ?? 0,
      orderNumber: name ?? 'Not Available',
      customerName: customerName,
      orderDate: dateOrder ?? 'Not Available',
      status: _mapStatus(state),
      total: amountTotal ?? 0,
      products: orderLines
          ?.map((line) => line.toEntity())
          .toList() ??
          [],
    );
  }

  String _mapStatus(String? state) {
    switch (state) {
      case 'draft':
        return 'Quotation';

      case 'sent':
        return 'Quotation Sent';

      case 'sale':
        return 'Sales Order';

      case 'cancel':
        return 'Cancelled';

      default:
        return state ?? 'Not Available';
    }
  }
}

extension SaleOrderLineModelMapper on SaleOrderLineModel {
  SaleOrderLineEntity toEntity() {
    String productName = 'Not Available';

    if (productId is List && productId.length > 1) {
      productName =
          productId[1]?.toString() ?? 'Not Available';
    }

    return SaleOrderLineEntity(
      id: id ?? 0,
      productName: productName,
      quantity: productUomQty ?? 0,
      unitPrice: priceUnit ?? 0,
      subtotal: priceSubtotal ?? 0,
    );
  }
}