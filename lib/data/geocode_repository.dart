import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_app/core/usecase/base_usecase.dart';

import '../core/common_models/oot_exception.dart';
import '../core/network/http_network.dart';
import '../core/network/interface_http_network.dart';
import '../core/network/interface_network_config_provider.dart';
import '../domain/models/location_info_model.dart';
import '../domain/repository/interface_geocode_repository.dart';
import '../environments/config/config.dart';

class GeocodeRepository extends InterfaceGeocodeRepository {
  static const String geocodePath = 'maps/api/geocode/json';

  late InterfaceHttpNetwork network;

  GeocodeRepository(
    InterfaceNetworkConfigProvider config,
  ) {
    network = HttpNetwork(
      baseUrl: Config().baseUrl ?? '',
      configProvider: config,
    );
  }

  @override
  Future<UsecaseValue<LocationInfoModel>> getLocationInfo(LatLng position) async {
    try {
      final response = await network.makeGetRequest(
        geocodePath,
        queryParameters: {
          'key': Config().mapKey,
          'latlng': '${position.latitude},${position.longitude}',
        },
      );
      final info = LocationInfoModel.fromJson(response);
      return Right(info);
    } catch (e) {
      return Left(OOTException(e.toString()));
    }
  }
}
