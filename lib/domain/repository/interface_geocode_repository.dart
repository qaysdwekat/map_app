import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../core/usecase/base_usecase.dart';
import '../models/location_info_model.dart';

abstract class InterfaceGeocodeRepository {
  Future<UsecaseValue<LocationInfoModel>> getLocationInfo(LatLng position);
}
