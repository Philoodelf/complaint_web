import 'package:complaint_web/core/api/api_consumer.dart';
import 'package:complaint_web/core/api/endpoints.dart';
import 'package:dio/dio.dart';

class DioConsumer extends ApiConsumer {
  final Dio dio;

  DioConsumer({required this.dio}) {
    dio.options.baseUrl = Endpoints.baseUrl;
    dio.options.headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
    };
  }
  @override
  void setAuthToken(String token) {
    dio.options.headers["Authorization"] = "Bearer $token";
  }

  @override
  Future delete(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameter,
  }) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future get(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameter,
  }) async {
    try {
      final response = await dio.get(path, queryParameters: queryParameter);
      return response;
    } on DioException catch (e) {
      print("❌ Dio GET Error: ${e.response?.data ?? e.message}");
      return e.response;
    }
  }

  @override
  Future patch(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameter,
  }) {
    // TODO: implement patch
    throw UnimplementedError();
  }

  @override
  Future<Response?> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameter,
  }) async {
    try {
      final response = await dio.post(
        path,
        data: data, // No need for FormData if API expects JSON
        queryParameters: queryParameter,
      );
      return response;
    } on DioException catch (e) {
      print("❌ DioException: ${e.response?.data ?? e.message}");
      return e.response;
    }
  }
}
