class ApiError implements Exception {
  ApiError({
    required this.message,
    this.errors,
  });

  final String message;
  final Map<String, List<String>>? errors;

  @override
  String toString() {
    if (errors == null || errors!.isEmpty) return 'ApiError: $message';
    return 'ApiError: $message, errors: $errors';
  }
}

class ApiEnvelope {
  ApiEnvelope({
    required this.success,
    required this.message,
    required this.data,
    this.errors,
  });

  final bool success;
  final String message;
  final dynamic data;
  final Map<String, List<String>>? errors;

  factory ApiEnvelope.fromJson(Map<String, dynamic> json) {
    final rawErrors = json['errors'];

    Map<String, List<String>>? parsedErrors;
    if (rawErrors is Map) {
      parsedErrors = rawErrors.map((key, value) {
        final list = value is List ? value : <dynamic>[];
        final stringList = list.map((e) => e.toString()).toList();
        return MapEntry(key.toString(), stringList);
      });
    }

    return ApiEnvelope(
      success: json['success'] == true,
      message: json['message']?.toString() ?? '',
      data: json['data'],
      errors: parsedErrors,
    );
  }

  List<T> requireList<T>(T Function(Map<String, dynamic>) fromJson) {
    if (!success) {
      throw ApiError(message: message, errors: errors);
    }

    if (data is! List) {
      throw ApiError(message: 'Unexpected data format');
    }

    final rawList = data as List;
    return rawList
        .map((e) => fromJson((e as Map).cast<String, dynamic>()))
        .toList();
  }

  T requireSingle<T>(T Function(Map<String, dynamic>) fromJson) {
    if (!success) {
      throw ApiError(message: message, errors: errors);
    }

    if (data is! Map) {
      throw ApiError(message: 'Unexpected data format');
    }

    final rawMap = data as Map;
    return fromJson(rawMap.cast<String, dynamic>());
  }
}

