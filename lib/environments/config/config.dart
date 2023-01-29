
class Config {
  String? env;
  bool? production;
  String? baseUrl;
  String? mapKey;

  static final Config _instance = Config._internal();

  factory Config() => _instance;

  Config._internal();

  void setConfig(config) {
    env = config['env'];
    production = config['production'];
    baseUrl = config['base_url'];
    mapKey = config['map_key'];
  }
}
