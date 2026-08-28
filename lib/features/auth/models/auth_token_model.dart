class AuthTokenModel {
  const AuthTokenModel({
    this.accessToken,
    this.refreshToken,
    this.tokenType,
    this.expiresIn,
  });

  final String? accessToken;
  final String? refreshToken;
  final String? tokenType;
  final int? expiresIn;

  factory AuthTokenModel.fromJson(Map<String, dynamic> json) {
    return AuthTokenModel(
      accessToken: json['access_token']?.toString(),
      refreshToken: json['refresh_token']?.toString(),
      tokenType: json['token_type']?.toString(),
      expiresIn: (json['expires_in'] as num?)?.toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'refresh_token': refreshToken,
      'token_type': tokenType,
      'expires_in': expiresIn,
    };
  }
}
