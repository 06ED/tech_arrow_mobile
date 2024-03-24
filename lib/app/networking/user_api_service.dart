import 'package:flutter_app/app/networking/api_service.dart';

class UserApiService extends ApiService {
  Future<bool> login(String email, String password) async =>
      await network(
          request: (request) => request.post("/login", data: {
                "email": email,
                "password": password,
              })) ==
      "success";

  Future<bool> register(String email, String password) async =>
      await network(
          request: (request) => request.post("/register", data: {
                "email": email,
                "password": password,
              })) ==
      "success";
}
