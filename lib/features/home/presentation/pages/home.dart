import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:task2shomewear/config/di/di.dart';
import 'package:task2shomewear/config/error_handling/result.dart';
import 'package:task2shomewear/core/helpers/my_responsive.dart';
import 'package:task2shomewear/core/values/app_strings.dart';

import 'package:task2shomewear/features/home/presentation/widgets/customer_card.dart';
import 'package:task2shomewear/features/home/presentation/widgets/customer_search_bar.dart';
import 'package:task2shomewear/features/home/presentation/widgets/home_error_and_empty_widgets.dart';

import 'package:task2shomewear/features/home/presentation/manager/home_cubit/home_cubit.dart';
import 'package:task2shomewear/features/home/presentation/manager/home_cubit/home_state.dart';
import 'package:task2shomewear/features/sales_orders/domain/use_case/check_internal_user_use_case.dart';
import 'package:task2shomewear/features/sales_orders/presentation/pages/sales_orders_screen.dart';

class HomeScreen extends StatelessWidget {
  final String dbName;
  final int uid;
  final String password;

  const HomeScreen({
    super.key,
    required this.dbName,
    required this.uid,
    required this.password,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _checkInternalUser(),
      builder: (context, snapshot) {
        final isInternalUser = snapshot.data ?? false;

        return BlocProvider(
          create: (_) => getIt<HomeCubit>()
            ..fetchCustomers(
              dbName: dbName,
              uid: uid,
              password: password,
            ),
          child: Scaffold(
            appBar: AppBar(
              title: const Text(AppStrings.customerList),
              centerTitle: true,

              actions: [
                if (isInternalUser)
                  IconButton(
                    tooltip: 'Sales Orders',
                    icon: const Icon(
                      Icons.shopping_cart_outlined,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SalesOrdersScreen(
                            dbName: dbName,
                            uid: uid,
                            password: password,
                          ),
                        ),
                      );
                    },
                  ),
              ],
            ),

            body: _HomeScreenBody(
              dbName: dbName,
              uid: uid,
              password: password,
            ),
          ),
        );
      },
    );
  }

  Future<bool> _checkInternalUser() async {
    final useCase = getIt<CheckInternalUserUseCase>();

    final result = await useCase(
      dbName: dbName,
      uid: uid,
      password: password,
    );

    switch (result) {
      case Success(:final data):
        return data;

      case Failure():
        return false;
    }
  }
}

class _HomeScreenBody extends StatelessWidget {
  final String dbName;
  final int uid;
  final String password;

  const _HomeScreenBody({
    required this.dbName,
    required this.uid,
    required this.password,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomerSearchBar(),

        Expanded(
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              if (state is HomeLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state is HomeErrorState) {
                return HomeErrorWidget(
                  errorMessage: state.errorMessage,
                  dbName: dbName,
                  uid: uid,
                  password: password,
                );
              }

              if (state is HomeSuccessState) {
                final customers = state.customers;

                if (customers.isEmpty) {
                  return const HomeEmptyWidget();
                }

                return ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: customers.length,
                  separatorBuilder: (_, _) => SizedBox(
                    height: MyResponsive.height(
                      value: 15,
                    ),
                  ),
                  itemBuilder: (context, index) {
                    return CustomerCard(
                      customer: customers[index],
                      dbName: dbName,
                      uid: uid,
                      password: password,
                    );
                  },
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ],
    );
  }
}