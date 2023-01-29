import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_app/core/usecase/base_usecase.dart';
import 'package:map_app/core/usecase/single_usecase_with_parameter.dart';

import '../models/location_info_model.dart';
import '../repository/interface_geocode_repository.dart';

class GetLocationInfoUsecase extends SingleUsecaseWithParameter<LocationInfoModel, LatLng> {
  final InterfaceGeocodeRepository repository;

  GetLocationInfoUsecase(this.repository);

  @override
  Future<UsecaseValue<LocationInfoModel>> call(LatLng data) {
    return repository.getLocationInfo(data);
  }
}
