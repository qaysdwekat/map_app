import 'package:get_it/get_it.dart';

import '../domain/usecase/get_location_info_usecase.dart';

Future<void> init(GetIt instance) async {
  instance.registerLazySingleton(
    () => GetLocationInfoUsecase(
      instance.call(),
    ),
  );
}
