import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:sales_crm/core/networking/api_constants.dart';


class Failure extends Equatable{
  final int? statusCode;
  final String? message;

  const Failure({
    this.statusCode,
    this.message,
  });

  factory Failure.fromJson(Map<String, dynamic> json) => Failure(
    statusCode: json["code"],
    message: json["info"],
  );

  @override
  List<Object?> get props => [statusCode, message];
}

class ServerFailure  {
  static Failure  handle(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionError:
          return const Failure(message: ApiError.apiConnectionError);
        case DioExceptionType.cancel:
          return const Failure(message: ApiError.apiCancel);
        case DioExceptionType.connectionTimeout:
          return const Failure(message: ApiError.apiConnectionTimeout);
        case DioExceptionType.unknown:
          return const Failure(
              message:
              "Connection to the server failed due to internet connection");
        case DioExceptionType.receiveTimeout:
          return const Failure(
              message: ApiError.apiReceiveTimeout);
        case DioExceptionType.badResponse:
          return _handleError(error.response?.statusCode, error.response?.data);
        case DioExceptionType.sendTimeout:
          return const Failure(
              message: ApiError.apiSendTimeout);
        default:
          return const Failure(message: "Something went wrong");
      }
    } else {
      return const Failure(message: "Unexpected error occurred");
    }
  }

  static Failure _handleError(int? statusCode, dynamic error) {
    if (error != null && error is Map<String, dynamic> && error.containsKey('error')) {
      final errorInfo = error['error'];
      return Failure(
        message: errorInfo['info'] ?? "Unknown error occurred",
        statusCode: errorInfo['code'],
      );
    } else {
      return Failure(
        message: "Unknown error occurred",
        statusCode: statusCode,
      );
    }
  }
}












