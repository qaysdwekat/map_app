abstract class InterfaceHttpNetwork {
  Future<dynamic> makeGetRequest(
    String path, {
    String? token,
    Map<String, dynamic>? queryParameters,
    bool? forceRefresh,
    Duration? cacheDuration,
  });

  Future<dynamic> makePostRequest(
    String path, {
    String? token,
    dynamic data,
    Map<String, dynamic>? queryParameters,
  });

  Future<dynamic> makePatchRequest(
    String path, {
    String? token,
    dynamic data,
    Map<String, dynamic>? queryParameters,
  });

  Future<dynamic> makeDeleteRequest(
    String path, {
    String? token,
    dynamic data,
    Map<String, dynamic>? queryParameters,
  });

  Future<dynamic> makePutRequest(
    String path, {
    String? token,
    dynamic data,
    Map<String, dynamic>? queryParameters,
  });
}
