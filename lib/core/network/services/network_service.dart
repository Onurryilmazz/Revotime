import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../models/network_response.dart';
import '../interceptors/auth_interceptor.dart';
import '../../constants/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NetworkService {
  late final Dio _dio;
  final SharedPreferences _prefs;

  NetworkService(this._prefs) {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppConstants.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    _dio.interceptors.addAll([
      AuthInterceptor(_prefs),
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
      ),
    ]);
  }

  Future<NetworkResponse<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
      );
      return NetworkResponse.success(
        data: response.data as T,
        statusCode: response.statusCode,
      );
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  Future<NetworkResponse<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return NetworkResponse.success(
        data: response.data as T,
        statusCode: response.statusCode,
      );
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  Future<NetworkResponse<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return NetworkResponse.success(
        data: response.data as T,
        statusCode: response.statusCode,
      );
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  Future<NetworkResponse<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return NetworkResponse.success(
        data: response.data as T,
        statusCode: response.statusCode,
      );
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  NetworkResponse<T> _handleError<T>(DioException error) {
    String? message;
    int? statusCode;

    if (error.response != null) {
      statusCode = error.response?.statusCode;
      message = error.response?.data?['message'] ?? error.message;
    } else {
      message = error.message;
    }

    return NetworkResponse.error(
      message: message,
      statusCode: statusCode,
    );
  }
} 