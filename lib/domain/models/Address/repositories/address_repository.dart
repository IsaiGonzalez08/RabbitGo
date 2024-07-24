import 'package:rabbit_go/domain/models/Address/address.dart';

abstract class AddressRepository {
  Future<Address> getAddress(String latitude, String longitude);
}