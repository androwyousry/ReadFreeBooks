import 'package:dio/dio.dart';

abstract class Failure {
  final String message;

  Failure(this.message);
}

class ServerFailure extends Failure {
  ServerFailure(super.message);

  factory ServerFailure.fromDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        ServerFailure('Connection timeout with ApiServer');
      case DioExceptionType.sendTimeout:
        ServerFailure('Send timeout with ApiServer');
      case DioExceptionType.receiveTimeout:
        ServerFailure('Receive timeout with ApiServer');
      case DioExceptionType.badCertificate:
        ServerFailure('Bad certificate with ApiServer');
      case DioExceptionType.badResponse:
        return ServerFailure.badResponce(
            e.response!.statusCode!, e.response?.data);
        break;
      case DioExceptionType.cancel:
        ServerFailure('Request to ApiServer was cancelled');
      case DioExceptionType.connectionError:
        ServerFailure('Connection error with ApiServer');
      case DioExceptionType.unknown:
        ServerFailure('Unknown error with ApiServer');

      default:
        ServerFailure('Something went wrong');
    }
    return ServerFailure('Something went wrong');
  }

  factory ServerFailure.badResponce(int statusCode, dynamic response) {
    switch (statusCode) {
      case 400:
        return ServerFailure(response['error']['message']);
      case 401:
        return ServerFailure(response['error']['message']);
      case 403:
        return ServerFailure(response['error']['message']);

      case 404:
        return ServerFailure('Not found');
      case 500:
        return ServerFailure('Internal server error');
      default:
        return ServerFailure('Something went wrong');
    }
  }
}
