// import 'package:dio/dio.dart';
// import 'package:inspireui/utils/logs.dart';

// class LoggingInterceptors extends Interceptor {
//   @override
//   void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
//     printLog(
//         "--> ${options.method != null ? options.method.toUpperCase() : 'METHOD'} ${options.uri}");
//     printLog("Headers:");
//     options.headers.forEach((k, v) => printLog('$k: $v'));
//     if (options.queryParameters != null) {
//       printLog("queryParameters:");
//       options.queryParameters.forEach((k, v) => printLog('$k: $v'));
//     }
//     if (options.data != null) {
//       printLog("Body: ${options.data}");
//     }
//     printLog(
//         "--> END ${options.method != null ? options.method.toUpperCase() : 'METHOD'}");

//     handler.next(options);
//   }

//   @override
//   void onError(DioError dioError, ErrorInterceptorHandler handler) {
//     printLog(
//         "<-- ${dioError.message} ${dioError.requestOptions.uri}");
//     printLog(
//         "${dioError.response?.data != null ? dioError.response?.data : 'Unknown Error'}");
//     printLog("<-- End error");

//     handler.next(dioError);
//   }

//   @override
//   void onResponse(Response response, ResponseInterceptorHandler handler) {
//     printLog(
//         "<-- ${response.statusCode} ${response.requestOptions.uri}");
//     printLog("Headers:");
//     response.headers.forEach((k, v) => printLog('$k: $v'));
//     printLog("Response: ${response.data}");
//     printLog("<-- END HTTP");

//     handler.next(response);
//   }
// }