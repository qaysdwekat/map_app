import 'package:get_it/get_it.dart';

import 'bloc_injector.dart' as bloc;
import 'external_injector.dart' as externalsdk;
import 'repository_injector.dart' as repository;
import 'usecase_injector.dart' as usecase;

final sl = GetIt.instance;

Future<void> init() async {
  await externalsdk.init(sl);
  await repository.init(sl);
  await usecase.init(sl);
  await bloc.init(sl);
}
