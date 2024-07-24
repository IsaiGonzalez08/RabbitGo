import 'package:flutter/material.dart';
import 'package:rabbit_go/domain/models/Address/address.dart';
import 'package:rabbit_go/domain/models/Address/repositories/address_repository.dart';
import 'package:rabbit_go/infraestructure/repositories/Address/address_repository_impl.dart';

class AddressProvider extends ChangeNotifier {
  final AddressRepository _addressRepository = AddressRepositoryImpl();

  Address _address = Address(district: '', street: '', postalCode: '');
  Address get address => _address;

  bool _loading = false;
  bool get loading => _loading;

  Future<void> getAddress(String latitude, String longitude) async {
    _loading = true;
    Address address = await _addressRepository.getAddress(latitude, longitude);
    _address = address;
    _loading = false;
    notifyListeners();
  }
}
