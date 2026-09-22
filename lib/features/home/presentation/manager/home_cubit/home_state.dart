import 'package:equatable/equatable.dart';
import 'package:task2shomewear/features/home/domain/entities/customer_list_entity.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitialState extends HomeState {
  const HomeInitialState();
}

class HomeLoadingState extends HomeState {
  const HomeLoadingState();
}

class HomeSuccessState extends HomeState {
  final List<CustomerEntity> customers;

  const HomeSuccessState(this.customers);

  @override
  List<Object?> get props => [customers];
}

class HomeErrorState extends HomeState {
  final String errorMessage;

  const HomeErrorState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}