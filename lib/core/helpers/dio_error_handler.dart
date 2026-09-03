import 'package:dio/dio.dart';

class DioErrorHandler implements Exception {
  final String message;

  DioErrorHandler._(this.message);

  factory DioErrorHandler.fromDioException(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return DioErrorHandler._("The connection timed out. Please try again.");
      case DioExceptionType.sendTimeout:
        return DioErrorHandler._(
          "We couldn't send your request in time. Please check your internet.",
        );
      case DioExceptionType.receiveTimeout:
        return DioErrorHandler._(
          "The server took too long to respond. Please try again later.",
        );
      case DioExceptionType.badCertificate:
        return DioErrorHandler._(
          "Secure connection failed. Please contact support.",
        );
      case DioExceptionType.badResponse:
        return DioErrorHandler._(_handleStatusError(error.response));
      case DioExceptionType.cancel:
        return DioErrorHandler._("The request was canceled.");
      case DioExceptionType.connectionError:
        return DioErrorHandler._(
          "No internet connection detected. Please check your network.",
        );
      case DioExceptionType.unknown:
      default:
        return DioErrorHandler._("Something went wrong. Please try again.");
    }
  }

  /// Parses HTTP status codes and extracts backend validation messages if they exist
  static String _handleStatusError(Response? response) {
    if (response == null)
      return "Received an invalid response from the server.";

    // 1. Try to extract a specific error message sent by your backend api
    if (response.data != null && response.data is Map<String, dynamic>) {
      final data = response.data as Map<String, dynamic>;
      // Customize these keys based on what your backend returns (e.g., 'error', 'msg')
      if (data.containsKey('message')) return data['message'].toString();
      if (data.containsKey('error')) return data['error'].toString();
    }

    // 2. Fallback to friendly messages based on HTTP Status Codes
    switch (response.statusCode) {
      case 400:
        return "The request was invalid. Please check your input.";
      case 401:
        return "You're not authorized.";
      case 403:
        return "You do not have permission to access this resource.";
      case 404:
        return "We couldn't find what you were looking for.";
      case 409:
        return "This action conflicts with existing data.";
      case 500:
        return "Our servers are experiencing issues. Please try again later.";
      case 503:
        return "The service is temporarily unavailable. Please try again shortly.";
      default:
        return "An unexpected server error occurred (${response.statusCode}).";
    }
  }

  @override
  String toString() => message;
}
