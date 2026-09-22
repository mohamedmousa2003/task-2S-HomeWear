import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:task2shomewear/config/di/di.dart';
import 'package:task2shomewear/features/sales_orders/domain/entities/sale_order_entity.dart';
import 'package:task2shomewear/features/sales_orders/presentation/cubit/sale_order/sale_order_cubit.dart';
import 'package:task2shomewear/features/sales_orders/presentation/cubit/sale_order/sale_order_state.dart';

class SaleOrderDetailsScreen extends StatelessWidget {
  final SaleOrderEntity order;
  final String dbName;
  final int uid;
  final String password;

  const SaleOrderDetailsScreen({
    super.key,
    required this.order,
    required this.dbName,
    required this.uid,
    required this.password,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SalesOrdersCubit>(),
      child: BlocListener<SalesOrdersCubit, SalesOrdersState>(
        listener: (context, state) {
          if (state is SaleOrderConfirmedState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Sale Order confirmed successfully',
                ),
              ),
            );

            Navigator.pop(context, true);
          }

          if (state is SaleOrderConfirmFailureState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },
        child: Scaffold(
          backgroundColor: const Color(0xFFF7F8FA),
          appBar: AppBar(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            elevation: 0,
            title: Text(
              order.orderNumber,
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w700,
                color: Color(0xFF111827),
              ),
            ),
          ),
          body: _buildBody(context),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    final isDraft =
        order.status == 'Quotation' ||
            order.status == 'Quotation Sent';

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _OrderHeader(),

          const SizedBox(height: 16),

          _OrderInformation(),

          const SizedBox(height: 24),

          _ProductsSection(),

          const SizedBox(height: 20),

          _TotalSection(),

          if (isDraft) ...[
            const SizedBox(height: 24),
            _ConfirmButton(),
          ],
        ],
      ),
    );
  }

  Widget _OrderHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF2563EB),
            Color(0xFF1D4ED8),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.receipt_long_rounded,
              color: Colors.white,
              size: 28,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Sales Order',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  order.orderNumber,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 8),

                _StatusBadge(
                  status: order.status,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _OrderInformation() {
    return _SectionCard(
      title: 'Order Information',
      icon: Icons.info_outline_rounded,
      child: Column(
        children: [
          _InfoRow(
            icon: Icons.person_outline_rounded,
            title: 'Customer',
            value: order.customerName,
          ),

          const Divider(
            height: 24,
            color: Color(0xFFE5E7EB),
          ),

          _InfoRow(
            icon: Icons.calendar_today_outlined,
            title: 'Order Date',
            value: order.orderDate,
          ),

          const Divider(
            height: 24,
            color: Color(0xFFE5E7EB),
          ),

          _InfoRow(
            icon: Icons.flag_outlined,
            title: 'Status',
            value: order.status,
          ),
        ],
      ),
    );
  }

  Widget _ProductsSection() {
    return _SectionCard(
      title: 'Products',
      icon: Icons.inventory_2_outlined,
      child: order.products.isEmpty
          ? const Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Center(
          child: Text(
            'No products found',
            style: TextStyle(
              color: Color(0xFF6B7280),
              fontSize: 14,
            ),
          ),
        ),
      )
          : Column(
        children: [
          ...order.products.asMap().entries.map(
                (entry) {
              final index = entry.key;
              final product = entry.value;

              return Column(
                children: [
                  _ProductItem(
                    productName: product.productName,
                    quantity: product.quantity,
                    unitPrice: product.unitPrice,
                    subtotal: product.subtotal,
                  ),

                  if (index != order.products.length - 1)
                    const Divider(
                      height: 24,
                      color: Color(0xFFE5E7EB),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _TotalSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFE5E7EB),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFFECFDF3),
              borderRadius: BorderRadius.circular(13),
            ),
            child: const Icon(
              Icons.payments_outlined,
              color: Color(0xFF15803D),
            ),
          ),

          const SizedBox(width: 12),

          const Expanded(
            child: Text(
              'Total Amount',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Color(0xFF374151),
              ),
            ),
          ),

          Text(
            order.total.toStringAsFixed(2),
            style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w800,
              color: Color(0xFF15803D),
            ),
          ),
        ],
      ),
    );
  }

  Widget _ConfirmButton() {
    return BlocBuilder<SalesOrdersCubit, SalesOrdersState>(
      builder: (context, state) {
        final isLoading =
        state is SaleOrderConfirmingState;

        return SizedBox(
          width: double.infinity,
          height: 54,
          child: ElevatedButton(
            onPressed: isLoading
                ? null
                : () {
              context
                  .read<SalesOrdersCubit>()
                  .confirmSaleOrder(
                dbName: dbName,
                uid: uid,
                password: password,
                orderId: order.id,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2563EB),
              disabledBackgroundColor: const Color(0xFFBFDBFE),
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: isLoading
                ? const SizedBox(
              width: 22,
              height: 22,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                valueColor:
                AlwaysStoppedAnimation<Color>(
                  Colors.white,
                ),
              ),
            )
                : const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.check_circle_outline_rounded,
                  size: 21,
                ),
                SizedBox(width: 8),
                Text(
                  'Confirm Order',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;

  const _SectionCard({
    required this.title,
    required this.icon,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFE5E7EB),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 20,
                color: const Color(0xFF2563EB),
              ),

              const SizedBox(width: 8),

              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF111827),
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          child,
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: const Color(0xFFF3F4F6),
            borderRadius: BorderRadius.circular(11),
          ),
          child: Icon(
            icon,
            size: 19,
            color: const Color(0xFF6B7280),
          ),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 11,
                  color: Color(0xFF9CA3AF),
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 3),

              Text(
                value,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF374151),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ProductItem extends StatelessWidget {
  final String productName;
  final double quantity;
  final double unitPrice;
  final double subtotal;

  const _ProductItem({
    required this.productName,
    required this.quantity,
    required this.unitPrice,
    required this.subtotal,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: const Color(0xFFEFF6FF),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.shopping_bag_outlined,
            size: 20,
            color: Color(0xFF2563EB),
          ),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Text(
                productName,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF111827),
                ),
              ),

              const SizedBox(height: 6),

              Text(
                '$quantity × ${unitPrice.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF6B7280),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(width: 12),

        Text(
          subtotal.toStringAsFixed(2),
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Color(0xFF374151),
          ),
        ),
      ],
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String status;

  const _StatusBadge({
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final data = _statusData(status);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: data.background,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: data.foreground,
              shape: BoxShape.circle,
            ),
          ),

          const SizedBox(width: 6),

          Text(
            status,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: data.foreground,
            ),
          ),
        ],
      ),
    );
  }

  _StatusColors _statusData(String status) {
    switch (status.toLowerCase()) {
      case 'sales order':
        return const _StatusColors(
          background: Color(0xFFECFDF3),
          foreground: Color(0xFF15803D),
        );

      case 'quotation':
        return const _StatusColors(
          background: Color(0xFFFFF7ED),
          foreground: Color(0xFFEA580C),
        );

      case 'quotation sent':
        return const _StatusColors(
          background: Color(0xFFEFF6FF),
          foreground: Color(0xFF2563EB),
        );

      case 'cancelled':
        return const _StatusColors(
          background: Color(0xFFFEF2F2),
          foreground: Color(0xFFDC2626),
        );

      default:
        return const _StatusColors(
          background: Color(0xFFF3F4F6),
          foreground: Color(0xFF6B7280),
        );
    }
  }
}

class _StatusColors {
  final Color background;
  final Color foreground;

  const _StatusColors({
    required this.background,
    required this.foreground,
  });
}