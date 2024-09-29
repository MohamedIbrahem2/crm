import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:crm/core/networking/api_constants.dart';


class Failure extends Equatable {
  final String? message;
  final Map<String, String>? errors;  // Add this field to handle specific field errors

  const Failure({
    this.message,
    this.errors,
  });

  factory Failure.fromJson(Map<String, dynamic> json) {
    return Failure(
      message: json["message"],
      errors: json.containsKey('errors')
          ? (json['errors'] as Map<String, dynamic>)
          .map((key, value) => MapEntry(key, value.toString()))
          : null,
    );
  }

  @override
  List<Object?> get props => [message, errors];
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
    if (error != null && error is Map<String, dynamic>) {
      String message = error['message'] ?? "Unknown error occurred";
      Map<String, String>? errors;

      if (error.containsKey('errors')) {
        errors = (error['errors'] as Map<String, dynamic>)
            .map((key, value) => MapEntry(key, value.toString()));
      }

      return Failure(
        message: message,
        errors: errors,
      );
    } else {
      return Failure(
        message: "Unknown error occurred",
      );
    }
  }

}












