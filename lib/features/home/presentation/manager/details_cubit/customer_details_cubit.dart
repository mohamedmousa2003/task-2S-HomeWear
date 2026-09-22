import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:task2shomewear/config/error_handling/result.dart';

import 'package:task2shomewear/features/home/domain/use_case/update_customer_phone_use_case.dart';

import 'customer_details_state.dart';

@injectable
class CustomerDetailsCubit extends Cubit<CustomerDetailsState> {
  final UpdateCustomerPhoneUseCase _updateCustomerPhoneUseCase;

  CustomerDetailsCubit(
      this._updateCustomerPhoneUseCase,
      ) : super(const CustomerDetailsInitialState());

  Future<void> updateCustomerPhone({
    required String dbName,
    required int uid,
    required String password,
    required int customerId,
    required String phone,
  }) async {
    final trimmedPhone = phone.trim();

    if (trimmedPhone.isEmpty) {
      emit(
        const CustomerDetailsUpdateFailureState(
          errorMessage: 'Phone number cannot be empty',
        ),
      );

      return;
    }

    emit(
      const CustomerDetailsUpdateLoadingState(),
    );

    final result = await _updateCustomerPhoneUseCase(
      dbName: dbName,
      uid: uid,
      password: password,
      customerId: customerId,
      phone: trimmedPhone,
    );

    switch (result) {
      case Success<bool>():
        emit(
          CustomerDetailsUpdateSuccessState(
            phone: trimmedPhone,
          ),
        );

      case Failure<bool>():
        emit(
          CustomerDetailsUpdateFailureState(
            errorMessage: result.errorMessage,
          ),
        );
    }
  }
}