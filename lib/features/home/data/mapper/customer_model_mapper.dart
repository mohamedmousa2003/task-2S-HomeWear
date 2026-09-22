import 'package:task2shomewear/features/home/data/model/response/customer_list_response.dart';
import 'package:task2shomewear/features/home/domain/entities/customer_list_entity.dart';
extension CustomerModelMapper on CustomerModel {
  CustomerEntity toEntity() {
    return CustomerEntity(
      id: id ?? 0,
      name: name?.trim().isNotEmpty == true
          ? name!.trim()
          : 'Not Available',
      phone: phone?.trim().isNotEmpty == true
          ? phone!.trim()
          : 'Not Available',
      city: city?.trim().isNotEmpty == true
          ? city!.trim()
          : 'Not Available',
      email: email?.trim().isNotEmpty == true
          ? email!.trim()
          : 'Not Available',
    );
  }
}