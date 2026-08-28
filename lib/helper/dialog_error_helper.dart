import 'package:dio/dio.dart';

import '../network/api/api_response.dart';

class DialogErrorData {
  const DialogErrorData({
    required this.title,
    required this.message,
  });

  final String title;
  final String message;
}

DialogErrorData parseDialogError(Object error) {
  if (error is DioException) {
    if (error.type == DioExceptionType.connectionError ||
        error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.sendTimeout ||
        error.type == DioExceptionType.unknown) {
      return const DialogErrorData(
        title: 'Internet Error',
        message: 'No Internet Connection',
      );
    }

    final statusCode = error.response?.statusCode;
    final data = error.response?.data;
    String apiMessage = 'Terjadi kesalahan pada server';

    if (data is Map<String, dynamic>) {
      final envelopeMessage = data['message']?.toString();
      if (envelopeMessage != null && envelopeMessage.isNotEmpty) {
        apiMessage = envelopeMessage;
      }
    }

    if (statusCode != null) {
      return DialogErrorData(
        title: 'Server Error',
        message: '($statusCode) $apiMessage',
      );
    }
  }

  if (error is ApiError) {
    return DialogErrorData(
      title: 'Server Error',
      message: error.message,
    );
  }

  return DialogErrorData(
    title: 'Unknown Error',
    message: error.toString(),
  );
}
