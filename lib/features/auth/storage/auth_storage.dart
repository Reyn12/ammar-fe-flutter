import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/auth_token_model.dart';
import '../models/login_result_model.dart';
import '../models/user_model.dart';

class AuthStorage {
  AuthStorage({FlutterSecureStorage? secureStorage})
    : secureStorage = secureStorage ?? const FlutterSecureStorage();

  final FlutterSecureStorage secureStorage;

  static const String accessTokenKey = 'auth_access_token';
  static const String refreshTokenKey = 'auth_refresh_token';
  static const String tokenTypeKey = 'auth_token_type';
  static const String expiresInKey = 'auth_expires_in';
  static const String userKey = 'auth_user';

  Future<void> saveLogin(LoginResultModel login) async {
    try {
      await Future.wait([
        secureStorage.write(
          key: accessTokenKey,
          value: login.token?.accessToken,
        ),
        secureStorage.write(
          key: refreshTokenKey,
          value: login.token?.refreshToken,
        ),
        secureStorage.write(key: tokenTypeKey, value: login.token?.tokenType),
        secureStorage.write(
          key: expiresInKey,
          value: login.token?.expiresIn?.toString(),
        ),
      ]);

      final prefs = await SharedPreferences.getInstance();
      if (login.user != null) {
        await prefs.setString(userKey, jsonEncode(login.user!.toJson()));
      }
    } catch (e, st) {
      debugPrint('│ ERROR saveLogin: $e');
      debugPrint('$st');
      rethrow;
    }
  }

  Future<String?> getAccessToken() {
    return secureStorage.read(key: accessTokenKey);
  }

  Future<String?> getRefreshToken() {
    return secureStorage.read(key: refreshTokenKey);
  }

  Future<String?> getTokenType() {
    return secureStorage.read(key: tokenTypeKey);
  }

  Future<int?> getExpiresIn() async {
    final value = await secureStorage.read(key: expiresInKey);
    return int.tryParse(value ?? '');
  }

  Future<AuthTokenModel?> getToken() async {
    final accessToken = await getAccessToken();
    if (accessToken == null || accessToken.isEmpty) return null;

    return AuthTokenModel(
      accessToken: accessToken,
      refreshToken: await getRefreshToken() ?? '',
      tokenType: await getTokenType() ?? 'Bearer',
      expiresIn: await getExpiresIn() ?? 0,
    );
  }

  Future<bool> hasToken() async {
    final token = await getAccessToken();
    return token != null && token.isNotEmpty;
  }

  Future<UserModel?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(userKey);
    if (raw == null || raw.isEmpty) return null;

    return UserModel.fromJson(jsonDecode(raw) as Map<String, dynamic>);
  }

  Future<void> clear() async {
    await Future.wait([
      secureStorage.delete(key: accessTokenKey),
      secureStorage.delete(key: refreshTokenKey),
      secureStorage.delete(key: tokenTypeKey),
      secureStorage.delete(key: expiresInKey),
    ]);

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(userKey);
  }
}
