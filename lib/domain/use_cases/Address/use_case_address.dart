import 'package:rabbit_go/domain/models/Address/address.dart';
import 'package:rabbit_go/domain/models/Address/repositories/address_repository.dart';

class GetAddressUseCase {
  final AddressRepository _addressRepository;
  GetAddressUseCase(this._addressRepository);

  Future<Address> getAddress(String latitude, String longitude) async {
     return await _addressRepository.getAddress(latitude, longitude);
  } 
  
}
