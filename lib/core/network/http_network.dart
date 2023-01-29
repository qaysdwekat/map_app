import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart' as dioCache;

import '../utils/logs.dart';
import 'interface_http_network.dart';
import 'interface_network_config_provider.dart';

class HttpNetwork extends InterfaceHttpNetwork {
  late Dio _dio;

  HttpNetwork({
    required InterfaceNetworkConfigProvider configProvider,
    required String baseUrl,
    bool hasAuthorization = true,
    bool isMultiPart = false,
    String? contentType,
  }) {
    BaseOptions options = BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: configProvider.getTimeOut(),
        receiveTimeout: configProvider.getTimeOut(),
        sendTimeout: configProvider.getTimeOut());

    if (contentType != null) {
      options.contentType = contentType;
    }
    _dio = Dio(options);

    _dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options, RequestInterceptorHandler handler) async {
      final newHeaders = await configProvider.getHeaders();
      options.headers.addAll(newHeaders);
      final authorizationHeader = options.headers['access_token']; //HttpHeaders.authorizationHeader];
      // 🧳🚨🧰⚙️🛡️📤📥📎🔗♻️💎
      printLog('💎💎💎💎💎💎💎💎💎💎💎💎💎💎💎💎💎💎💎💎💎💎💎💎💎💎💎💎💎💎💎💎💎');
      String parameters = '';
      options.queryParameters.forEach((key, value) {
        parameters = '$key=$value&';
      });
      final headers = options.headers;
      printLog('🔗🔗[Network][Url][Parameters] $parameters');
      printLog('🔗🔗[Network][Url][Headers] $headers');
      printLog('🔗🔗[Network][Url] ${options.baseUrl}${options.path}?$parameters');

      if (authorizationHeader?.isNotEmpty != false) {
        printLog('🔐🔐[Network][Token] $authorizationHeader');
      }
      if (options.data != null) {
        printLog('🧰🧰[Network][Body] ${options.data}');
      }
      printLog('💎💎💎💎💎💎💎💎💎💎💎💎💎💎💎💎💎💎💎💎💎💎💎💎💎💎💎💎💎💎💎💎💎');
      handler.next(options);
    }));

    _dio.interceptors
        .add(InterceptorsWrapper(onResponse: (Response response, ResponseInterceptorHandler handler) async {
      // 🧳🚨🧰⚙️🛡️📤📥📎🔗♻️💎
      printLog('💎💎💎💎💎💎💎💎💎💎💎💎💎💎💎💎💎💎💎💎💎💎💎💎💎💎💎💎💎💎💎💎💎');
      // response.data
      printLog(
          '🔗📟[${response.statusCode}]🔗📟[Network][onResponse][Url] ${response.requestOptions.baseUrl}${response.requestOptions.path}');
      if (response.data != null) {
        printLog('📥📥[Network][onResponse][Body] ${response.data}');
      }
      printLog('💎💎💎💎💎💎💎💎💎💎💎💎💎💎💎💎💎💎💎💎💎💎💎💎💎💎💎💎💎💎💎💎💎');
      handler.next(response);
    }));
    // _dio.interceptors.add(LoggingInterceptors());
  }

  @override
  Future<dynamic> makeGetRequest(
    String path, {
    String? token,
    Map<String, dynamic>? queryParameters,
    bool? forceRefresh,
    Duration? cacheDuration,
  }) async {
    try {
      if (token != null) {
        // ignore: avoid_single_cascade_in_expression_statements
        _dio.options..headers.addAll({'access_token': token});
        // ..headers.addAll({
        //   HttpHeaders.authorizationHeader: 'Bearer $token',
        // });
      }
      Options? diOptions;
      if (cacheDuration != null) {
        diOptions = dioCache.buildCacheOptions(
          cacheDuration,
          subKey: queryParameters.toString(),
          forceRefresh: forceRefresh,
        );
      }
      Response response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: diOptions,
      );
      // final Options options  = Options();
      // ..headers.addAll({
      //   HttpHeaders.authorizationHeader: 'Bearer $token',
      // });

      if ((response.statusCode ?? 0) >= 200 && (response.statusCode ?? 0) <= 299) {
        return response.data;
      }
    } on DioError catch (e) {
      String message = e.message;
      try {
        message = e.response?.data['message'] ?? e.message;
      } catch (_) {}
      printLog('🚨[Network] Exception for $path');
      printLog('🚨[Network][Message] Exception for $message');
      printLog(e);
      throw message;
    } catch (e) {
      printLog('🚨[Network] Exception for $path');
      printLog(e);
      rethrow;
    }
  }

  @override
  Future<dynamic> makePostRequest(
    String path, {
    String? token,
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      if (token != null) {
        // ignore: avoid_single_cascade_in_expression_statements
        _dio.options..headers.addAll({'access_token': token});
        // ..headers.addAll({
        //   HttpHeaders.authorizationHeader: 'Bearer $token',
        // });
      }
      Response response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      // final Options options  = Options();
      // ..headers.addAll({
      //   HttpHeaders.authorizationHeader: 'Bearer $token',
      // });

      if ((response.statusCode ?? 0) >= 200 && (response.statusCode ?? 0) <= 299) {
        return response.data;
      }
    } on DioError catch (e) {
      String message = e.message;
      try {
        message = e.response?.data['message'] ?? e.message;
      } catch (_) {}
      printLog('🚨[Network] Exception for $path');
      printLog('🚨[Network][Message] Exception for $message');
      printLog(e.stackTrace);
      throw message;
    } catch (e) {
      printLog('🚨[Network] Exception for $path');
      printLog(e);
      rethrow;
    }
  }

  @override
  Future<dynamic> makePatchRequest(
    String path, {
    String? token,
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      if (token != null) {
        // ignore: avoid_single_cascade_in_expression_statements
        _dio.options..headers.addAll({'access_token': token});
        // ..headers.addAll({
        //   HttpHeaders.authorizationHeader: 'Bearer $token',
        // });
      }
      Response response = await _dio.patch(path, data: data, queryParameters: queryParameters);
      // final Options options  = Options();
      // ..headers.addAll({
      //   HttpHeaders.authorizationHeader: 'Bearer $token',
      // });

      if (response.statusCode == 200) {
        return response.data;
      }
    } on DioError catch (e) {
      String message = e.message;
      try {
        message = e.response?.data['message'] ?? e.message;
      } catch (_) {}
      printLog('🚨[Network] Exception for $path');
      printLog('🚨[Network][Message] Exception for $message');
      printLog(e);
      throw message;
    } catch (e) {
      printLog('🚨[Network] Exception for $path');
      printLog(e);
      rethrow;
    }
  }

  @override
  Future<dynamic> makeDeleteRequest(
    String path, {
    String? token,
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      if (token != null) {
        // ignore: avoid_single_cascade_in_expression_statements
        _dio.options..headers.addAll({'access_token': token});
        // ..headers.addAll({
        //   HttpHeaders.authorizationHeader: 'Bearer $token',
        // });
      }
      // final Options options  = Options();
      // ..headers.addAll({
      //   HttpHeaders.authorizationHeader: 'Bearer $token',
      // });

      Response response = await _dio.delete(path, data: data, queryParameters: queryParameters);

      if (response.statusCode == 200) {
        return response.data;
      }
    } on DioError catch (e) {
      String message = e.message;
      try {
        message = e.response?.data['message'] ?? e.message;
      } catch (_) {}
      printLog('🚨[Network] Exception for $path');
      printLog('🚨[Network][Message] Exception for $message');
      printLog(e);
      throw message;
    } catch (e) {
      printLog('🚨[Network] Exception for $path');
      printLog(e);
      rethrow;
    }
  }

  @override
  Future<dynamic> makePutRequest(
    String path, {
    String? token,
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      if (token != null) {
        // ignore: avoid_single_cascade_in_expression_statements
        _dio.options..headers.addAll({'access_token': token});
        // ..headers.addAll({
        //   HttpHeaders.authorizationHeader: 'Bearer $token',
        // });
      }
      // final Options options  = Options();
      // ..headers.addAll({
      //   HttpHeaders.authorizationHeader: 'Bearer $token',
      // });
      Response response = await _dio.put(path, data: data, queryParameters: queryParameters);

      if (response.statusCode == 200) {
        return response.data;
      }
    } on DioError catch (e) {
      String message = e.message;
      try {
        message = e.response?.data['message'] ?? e.message;
      } catch (_) {}
      printLog('🚨[Network] Exception for $path');
      printLog('🚨[Network][Message] Exception for $message');
      printLog(e);
      throw message;
    } catch (e) {
      printLog('🚨[Network] Exception for $path');
      printLog(e);
      rethrow;
    }
  }
}
