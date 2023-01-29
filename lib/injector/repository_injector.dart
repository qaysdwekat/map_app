import 'package:get_it/get_it.dart';

import '../data/geocode_repository.dart';
import '../domain/repository/interface_geocode_repository.dart';

Future<void> init(GetIt instance) async {
  instance.registerLazySingleton<InterfaceGeocodeRepository>(
    () => GeocodeRepository(
      instance.call(),
    ),
  );
}
