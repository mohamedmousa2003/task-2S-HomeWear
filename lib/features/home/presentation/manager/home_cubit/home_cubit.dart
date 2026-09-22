import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:task2shomewear/config/error_handling/result.dart';
import 'package:task2shomewear/core/values/app_strings.dart';
import 'package:task2shomewear/features/home/domain/entities/customer_list_entity.dart';
import 'package:task2shomewear/features/home/domain/use_case/customer_details_use_case.dart';

import 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final GetCustomersUseCase _getCustomersUseCase;

  HomeCubit(this._getCustomersUseCase)
      : super(const HomeInitialState());

  /// Original customers list
  List<CustomerEntity> _allCustomers = [];

  Future<void> fetchCustomers({
    required String dbName,
    required int uid,
    required String password,
  }) async {
    emit(const HomeLoadingState());

    final result = await _getCustomersUseCase(
      dbName: dbName,
      uid: uid,
      password: password,
    );

    switch (result) {
      case Success(:final data):
        if (data.isEmpty) {
          _allCustomers = [];

          emit(
            const HomeErrorState('Not Found Data'),
          );
        } else {
          _allCustomers = data;

          emit(
            HomeSuccessState(data),
          );
        }

      case Failure(:final errorMessage):
        _allCustomers = [];

        emit(
          HomeErrorState(errorMessage),
        );
    }
  }

  /// Search customers locally by name
  void searchCustomers(String query) {
    if (_allCustomers.isEmpty) {
      return;
    }

    final searchQuery = query.trim().toLowerCase();

    /// If search field is empty,
    /// show all customers again.
    if (searchQuery.isEmpty) {
      emit(
        HomeSuccessState(_allCustomers),
      );
      return;
    }

    final filteredCustomers = _allCustomers.where((customer) {
      return customer.name.toLowerCase().contains(searchQuery);
    }).toList();

    if (filteredCustomers.isEmpty) {
      emit(
        const HomeErrorState(
          AppStrings.noClientsMatchSearch,
        ),
      );
    } else {
      emit(
        HomeSuccessState(filteredCustomers),
      );
    }
  }
}