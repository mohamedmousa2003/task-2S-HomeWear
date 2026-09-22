import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task2shomewear/core/utils/app_colors.dart';
import 'package:task2shomewear/core/utils/app_text_styles.dart';

import 'package:task2shomewear/features/home/domain/entities/customer_list_entity.dart';
import 'package:task2shomewear/features/home/presentation/manager/home_cubit/home_cubit.dart';
import 'package:task2shomewear/features/home/presentation/pages/customer_details_screen.dart';

class CustomerCard extends StatelessWidget {
  final CustomerEntity customer;

  final String dbName;
  final int uid;
  final String password;

  const CustomerCard({
    super.key,
    required this.customer,
    required this.dbName,
    required this.uid,
    required this.password,
  });

  @override
  Widget build(BuildContext context) {
    final initial = customer.name.trim().isNotEmpty
        ? customer.name.trim()[0].toUpperCase()
        : '?';

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () async {
          final result = await Navigator.push<bool>(
            context,
            MaterialPageRoute(
              builder: (context) => CustomerDetailsScreen(
                customer: customer,
                dbName: dbName,
                uid: uid,
                password: password,
              ),
            ),
          );

          if (result == true && context.mounted) {
            await context.read<HomeCubit>().fetchCustomers(
              dbName: dbName,
              uid: uid,
              password: password,
            );
          }
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: Colors.grey.shade200,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              _CustomerAvatar(
                initial: initial,
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      customer.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.font16BoldDark,
                    ),

                    const SizedBox(height: 8),

                    Row(
                      children: [
                        const Icon(
                          Icons.phone_outlined,
                          size: 15,
                          color: Color(0xFF6B7280),
                        ),

                        const SizedBox(width: 6),

                        Expanded(
                          child: Text(
                            customer.phone,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.font14MediumDark,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 5),

                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          size: 15,
                          color: Color(0xFF6B7280),
                        ),

                        const SizedBox(width: 6),

                        Expanded(
                          child: Text(
                            customer.city,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.font14MediumDark,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 10),

              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 15,
                  color: AppColors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomerAvatar extends StatelessWidget {
  final String initial;

  const _CustomerAvatar({
    required this.initial,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
          color: AppColors.primary
      ),
      alignment: Alignment.center,
      child: Text(
        initial,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}