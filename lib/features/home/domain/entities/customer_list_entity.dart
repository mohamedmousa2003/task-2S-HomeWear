import 'package:equatable/equatable.dart';

class CustomerEntity extends Equatable {
  final int id;
  final String name;
  final String phone;
  final String city;
  final String email;

  const CustomerEntity({
    required this.id,
    required this.name,
    required this.phone,
    required this.city,
    required this.email,
  });

  List<Object?> get props => [
    id,
    name,
    phone,
    city,
    email,
  ];
}