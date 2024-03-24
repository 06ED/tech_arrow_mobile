import 'package:flutter_app/app/networking/user_api_service.dart';
import 'package:nylo_framework/nylo_framework.dart';

class UserController extends NyController {
  Future<bool> login(String email, String password) async =>
      await api<UserApiService>((request) => request.login(email, password));

  Future<bool> register(String email, String password) async =>
      await api<UserApiService>((request) => request.register(email, password));
}
