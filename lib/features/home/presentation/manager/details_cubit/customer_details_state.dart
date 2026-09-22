import 'package:equatable/equatable.dart';

sealed class CustomerDetailsState extends Equatable {
  const CustomerDetailsState();

  @override
  List<Object?> get props => [];
}

class CustomerDetailsInitialState extends CustomerDetailsState {
  const CustomerDetailsInitialState();
}

class CustomerDetailsUpdateLoadingState extends CustomerDetailsState {
  const CustomerDetailsUpdateLoadingState();
}

class CustomerDetailsUpdateSuccessState extends CustomerDetailsState {
  final String phone;

  const CustomerDetailsUpdateSuccessState({
    required this.phone,
  });

  @override
  List<Object?> get props => [phone];
}

class CustomerDetailsUpdateFailureState extends CustomerDetailsState {
  final String errorMessage;

  const CustomerDetailsUpdateFailureState({
    required this.errorMessage,
  });

  @override
  List<Object?> get props => [errorMessage];
}