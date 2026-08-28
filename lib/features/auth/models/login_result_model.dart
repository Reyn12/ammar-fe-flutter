import 'auth_token_model.dart';
import 'user_model.dart';

class LoginResultModel {
  const LoginResultModel({this.token, this.user});

  final AuthTokenModel? token;
  final UserModel? user;

  factory LoginResultModel.fromJson(Map<String, dynamic> json) {
    final rawUser = json['user'];

    return LoginResultModel(
      token: AuthTokenModel.fromJson(json),
      user: rawUser is Map
          ? UserModel.fromJson(rawUser.cast<String, dynamic>())
          : null,
    );
  }
}
