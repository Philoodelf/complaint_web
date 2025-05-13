import 'package:complaint_web/core/api/api_consumer.dart';
import 'package:complaint_web/core/api/endpoints.dart';
import 'package:dio/dio.dart';

class DioConsumer extends ApiConsumer {
  final Dio dio;

  DioConsumer({required this.dio, String? typeComplaintId}) {
    dio.options.baseUrl = Endpoints.baseUrl;
    dio.options.headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      'PageNo': '1',
      'NoOfItems': '20',
      'userId': "d03a0db5-6208-4a27-a1be-1f9aa4c3cc26",
       if (typeComplaintId != null && typeComplaintId.isNotEmpty)
        'TypecomplaintId': typeComplaintId, // ✅ Only add if valid
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
    Map<String, dynamic>? queryParameters,
  }) {
    // TODO: implement delete
    throw UnimplementedError();
  }

//   @override
//  Future<Response?> get(
//   String path, {
//   Object? data,
//   Map<String, dynamic>? queryParameters,
//   Map<String, dynamic>? headers,
// }) async {
//     try {
//       final response = await dio.get(
//         path,
//         queryParameters: queryParameters,
//         options: Options( headers: headers
//           // headers: headers, // Set headers here
//         ),
//       );
//       return response;
//     } on DioException catch (e) {
//       print("❌ Dio GET Error: ${e.response?.data ?? e.message}");
//       return e.response;
//     }
//   }
   @override
Future<Response?> get(
  String path, {
  Object? data,
  Map<String, dynamic>? queryParameters,
  Map<String, dynamic>? headers,
}) async {
  try {
    final response = await dio.get(
      path,
      queryParameters: queryParameters,
      options: Options(headers: headers),
    );
    return response;
  } on DioException catch (e) {
    print("❌ Dio GET Error: ${e.response?.data ?? e.message}");
    return e.response; // May be null
  }
}

  @override
  Future patch(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) {
    // TODO: implement patch
    throw UnimplementedError();
  }

  @override
  Future<Response?> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.post(
        path,
        data: data, // No need for FormData if API expects JSON
        queryParameters: queryParameters,
      );
      return response;
    } on DioException catch (e) {
      print("❌ DioException: ${e.response?.data ?? e.message}");
      return e.response;
    }
  }
}
