import 'package:get_it/get_it.dart';

import '../core/network/interface_network_config_provider.dart';
import '../core/network/network_config_provider.dart';

Future<void> init(GetIt instance) async {
  instance.registerLazySingleton<InterfaceNetworkConfigProvider>(
    () => NetworkConfigProvider(),
  );
}
