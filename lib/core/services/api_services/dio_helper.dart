import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart'; // Required for DefaultHttpClientAdapter
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../constant/app_links.dart';
import '../token_management/auth_interceptor.dart';

class DioProvider {
  static final DioProvider _instance = DioProvider._internal();

  late Dio _dio;

  factory DioProvider() {
    return _instance;
  }

  DioProvider._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppLinks.server,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
      ),
    );

    // 👇 Allow self-signed SSL (not safe for production)
    (_dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      final client = HttpClient();
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      return client;
    };

    // Add auth interceptor first (before logger) to handle token refresh
    _dio.interceptors.add(AuthInterceptor());

    _dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
        request: true,
        compact: true,
        enabled: true,
      ),
    );
  }

  Dio get dio => _dio;

  static String handleDioError(DioException error) {
    if (error.type == DioExceptionType.connectionTimeout) {
      return "Connection timeout";
    } else if (error.type == DioExceptionType.badResponse) {
      return "Server error: ${error.response?.statusCode}";
    } else {
      return "Something went wrong";
    }
  }
}
