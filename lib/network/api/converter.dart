import 'api_response.dart';

class Converter {
  static List<T> list<T>(
    dynamic responseData,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    if (responseData is! Map<String, dynamic>) {
      throw ApiError(message: 'Unexpected response format');
    }

    final envelope = ApiEnvelope.fromJson(responseData);

    return envelope.requireList(fromJson);
  }

  static T single<T>(
    dynamic responseData,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    if (responseData is! Map<String, dynamic>) {
      throw ApiError(message: 'Unexpected response format');
    }

    final envelope = ApiEnvelope.fromJson(responseData);
    
    return envelope.requireSingle(fromJson);
  }
}

