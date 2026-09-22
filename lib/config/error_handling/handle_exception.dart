import 'package:dio/dio.dart';

import '../../core/values/app_response_error_messages.dart';

class NetworkException {
  static String getMessageError(Object exception) {
    if (exception is DioException) {
      switch (exception.type) {
        case DioExceptionType.connectionTimeout:
          return AppResponseErrorMessages.connectionTimeoutMessage;

        case DioExceptionType.sendTimeout:
          return AppResponseErrorMessages.sendTimeoutMessage;

        case DioExceptionType.receiveTimeout:
          return AppResponseErrorMessages.receiveTimeoutMessage;

        case DioExceptionType.transformTimeout:
          return AppResponseErrorMessages.connectionTimeoutMessage;

        case DioExceptionType.badCertificate:
          return AppResponseErrorMessages.badCertificateMessage;

        case DioExceptionType.badResponse:
          return _handleMessageResponse(exception);

        case DioExceptionType.cancel:
          return AppResponseErrorMessages.requestCancelledMessage;

        case DioExceptionType.connectionError:
          return AppResponseErrorMessages.connectionErrorMessage;

        case DioExceptionType.unknown:
          return AppResponseErrorMessages.unknownErrorMessage;
      }
    }

    return AppResponseErrorMessages.unexpectedErrorMessage;
  }

  static String _handleMessageResponse(DioException exception) {
    final response = exception.response;

    if (response == null) {
      return AppResponseErrorMessages.defaultError;
    }

    final statusCode = response.statusCode;
    final data = response.data;

    if (data is Map) {
      final message = data['message'];

      if (message != null && message.toString().isNotEmpty) {
        return message.toString();
      }

      final error = data['error'];

      if (error != null && error.toString().isNotEmpty) {
        return error.toString();
      }
    }

    switch (statusCode) {
      case 400:
        return AppResponseErrorMessages.error400;

      case 401:
        return AppResponseErrorMessages.error401;

      case 403:
        return AppResponseErrorMessages.error403;

      case 404:
        return AppResponseErrorMessages.error404;

      case 408:
        return AppResponseErrorMessages.error408;

      case 429:
        return AppResponseErrorMessages.error429;

      case 500:
        return AppResponseErrorMessages.error500;

      case 502:
        return AppResponseErrorMessages.error502;

      case 503:
        return AppResponseErrorMessages.error503;

      case 504:
        return AppResponseErrorMessages.error504;

      default:
        return 'Server error (${statusCode ?? 'unknown'}). Please try again.';
    }
  }
}