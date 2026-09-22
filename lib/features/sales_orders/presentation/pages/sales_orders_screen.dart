import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:task2shomewear/config/di/di.dart';
import 'package:task2shomewear/core/utils/app_colors.dart';
import 'package:task2shomewear/features/sales_orders/presentation/cubit/sale_order/sale_order_cubit.dart';
import 'package:task2shomewear/features/sales_orders/presentation/cubit/sale_order/sale_order_state.dart';
import 'package:task2shomewear/features/sales_orders/presentation/pages/sale_order_details_screen.dart';

class SalesOrdersScreen extends StatelessWidget {
  final String dbName;
  final int uid;
  final String password;

  const SalesOrdersScreen({
    super.key,
    required this.dbName,
    required this.uid,
    required this.password,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SalesOrdersCubit>()
        ..fetchSaleOrders(
          dbName: dbName,
          uid: uid,
          password: password,
        ),
      child: Scaffold(
        backgroundColor: const Color(0xFFF7F8FA),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          centerTitle: false,
          title: const Text(
            'Sales Orders',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppColors.black,
            ),
          ),
        ),
        body: BlocBuilder<SalesOrdersCubit, SalesOrdersState>(
          builder: (context, state) {
            switch (state) {
              case SalesOrdersInitialState():
              case SalesOrdersLoadingState():
                return const _SalesOrdersLoading();

              case SalesOrdersErrorState(:final message):
                return _SalesOrdersError(
                  message: message,
                );

              case SalesOrdersSuccessState(:final orders):
                if (orders.isEmpty) {
                  return const _SalesOrdersEmpty();
                }

                return _SalesOrdersList(
                  orders: orders,
                  dbName: dbName,
                  uid: uid,
                  password: password,
                );

              case SaleOrderConfirmingState():
              case SaleOrderConfirmedState():
              case SaleOrderConfirmFailureState():
                return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}

class _SalesOrdersList extends StatelessWidget {
  final List orders;
  final String dbName;
  final int uid;
  final String password;

  const _SalesOrdersList({
    required this.orders,
    required this.dbName,
    required this.uid,
    required this.password,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(
        16,
        20,
        16,
        24,
      ),
      children: [
        const _SalesOrdersHeader(),

        const SizedBox(height: 20),

        ...List.generate(
          orders.length,
              (index) {
            final order = orders[index];

            return Padding(
              padding: EdgeInsets.only(
                bottom: index == orders.length - 1 ? 0 : 12,
              ),
              child: _SaleOrderCard(
                order: order,
                dbName: dbName,
                uid: uid,
                password: password,
              ),
            );
          },
        ),
      ],
    );
  }
}

class _SalesOrdersHeader extends StatelessWidget {
  const _SalesOrdersHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
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
            width: 52,
            height: 52,
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

          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sales Orders',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Manage and review customer orders',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SaleOrderCard extends StatelessWidget {
  final dynamic order;

  final String dbName;
  final int uid;
  final String password;

  const _SaleOrderCard({
    required this.order,
    required this.dbName,
    required this.uid,
    required this.password,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => SaleOrderDetailsScreen(
                order: order,
                dbName: dbName,
                uid: uid,
                password: password,
              ),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: const Color(0xFFE5E7EB),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(
                  alpha: 0.04,
                ),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF6FF),
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: const Icon(
                      Icons.receipt_outlined,
                      color: Color(0xFF2563EB),
                      size: 23,
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'ORDER',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1,
                            color: Color(0xFF9CA3AF),
                          ),
                        ),

                        const SizedBox(height: 3),

                        Text(
                          order.orderNumber,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF111827),
                          ),
                        ),
                      ],
                    ),
                  ),

                  _StatusBadge(
                    status: order.status,
                  ),
                ],
              ),

              const SizedBox(height: 16),

              const Divider(
                height: 1,
                color: Color(0xFFE5E7EB),
              ),

              const SizedBox(height: 14),

              Row(
                children: [
                  Expanded(
                    child: _OrderInfoItem(
                      icon: Icons.person_outline_rounded,
                      label: 'Customer',
                      value: order.customerName,
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: _OrderInfoItem(
                      icon: Icons.calendar_today_outlined,
                      label: 'Order Date',
                      value: order.orderDate,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              Row(
                children: [
                  Expanded(
                    child: _OrderInfoItem(
                      icon: Icons.payments_outlined,
                      label: 'Total',
                      value: '${order.total}',
                      valueStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF2563EB),
                      ),
                    ),
                  ),

                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F4F6),
                      borderRadius: BorderRadius.circular(11),
                    ),
                    child: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 15,
                      color: Color(0xFF6B7280),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OrderInfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final TextStyle? valueStyle;

  const _OrderInfoItem({
    required this.icon,
    required this.label,
    required this.value,
    this.valueStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 18,
          color: const Color(0xFF6B7280),
        ),

        const SizedBox(width: 8),

        Expanded(
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF9CA3AF),
                ),
              ),

              const SizedBox(height: 3),

              Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: valueStyle ??
                    const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF374151),
                    ),
              ),
            ],
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
    final statusData = _getStatusData(status);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: statusData.backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: statusData.foregroundColor,
              shape: BoxShape.circle,
            ),
          ),

          const SizedBox(width: 6),

          Text(
            status,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: statusData.foregroundColor,
            ),
          ),
        ],
      ),
    );
  }

  _StatusData _getStatusData(String status) {
    switch (status.toLowerCase()) {
      case 'sales order':
        return const _StatusData(
          backgroundColor: Color(0xFFECFDF3),
          foregroundColor: Color(0xFF15803D),
        );

      case 'quotation':
        return const _StatusData(
          backgroundColor: Color(0xFFFFF7ED),
          foregroundColor: Color(0xFFEA580C),
        );

      case 'quotation sent':
        return const _StatusData(
          backgroundColor: Color(0xFFEFF6FF),
          foregroundColor: Color(0xFF2563EB),
        );

      case 'cancelled':
        return const _StatusData(
          backgroundColor: Color(0xFFFEF2F2),
          foregroundColor: Color(0xFFDC2626),
        );

      default:
        return const _StatusData(
          backgroundColor: Color(0xFFF3F4F6),
          foregroundColor: Color(0xFF6B7280),
        );
    }
  }
}

class _StatusData {
  final Color backgroundColor;
  final Color foregroundColor;

  const _StatusData({
    required this.backgroundColor,
    required this.foregroundColor,
  });
}

class _SalesOrdersLoading extends StatelessWidget {
  const _SalesOrdersLoading();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Center(
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
            ),
          ),
        ),
      ],
    );
  }
}

class _SalesOrdersEmpty extends StatelessWidget {
  const _SalesOrdersEmpty();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: const Color(0xFFEFF6FF),
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Icon(
                Icons.receipt_long_outlined,
                size: 40,
                color: Color(0xFF2563EB),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'No Sales Orders',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w700,
                color: Color(0xFF111827),
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'There are no sales orders available at the moment.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF6B7280),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SalesOrdersError extends StatelessWidget {
  final String message;

  const _SalesOrdersError({
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: const Color(0xFFFEF2F2),
                borderRadius: BorderRadius.circular(22),
              ),
              child: const Icon(
                Icons.error_outline_rounded,
                size: 38,
                color: Color(0xFFDC2626),
              ),
            ),

            const SizedBox(height: 18),

            const Text(
              'Something went wrong',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF111827),
              ),
            ),

            const SizedBox(height: 8),

            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF6B7280),
              ),
            ),
          ],
        ),
      ),
    );
  }
}