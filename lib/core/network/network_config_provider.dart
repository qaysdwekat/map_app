import './interface_network_config_provider.dart';

class NetworkConfigProvider extends InterfaceNetworkConfigProvider {
  @override
  Future<Map<String, dynamic>> getHeaders() => Future.value({
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'X-bundle-id': 'Bundle Id.',
        'X-app-version': 'App Version',
        'X-platform-type': 'Platform Type',
        'X-os-version': 'OS Version',
        'X-accept-language': 'en'
      });

  @override
  int getTimeOut() => 60000;
}
