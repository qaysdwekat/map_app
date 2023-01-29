import 'package:get_it/get_it.dart';

import '../presentation/home/home_bloc.dart';

Future<void> init(GetIt instance) async {
  instance.registerLazySingleton(
    () => HomeBloc(
      instance.call(),
    ),
  );
}
