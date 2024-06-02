import 'package:dio/dio.dart';

class ApiServices {
  final Dio _dio;
  final _baseUrl = 'https://www.googleapis.com/books/v1/';

  ApiServices(this._dio);

  Future<Map<String, dynamic>> get({required String endpoint}) async {
    final response = await _dio.get(_baseUrl + endpoint);
    return response.data;
  }
}
