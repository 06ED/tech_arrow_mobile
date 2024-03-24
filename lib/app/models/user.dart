import 'package:nylo_framework/nylo_framework.dart';

class User extends Model {
  String? email;

  User(this.email);

  User.fromJson(dynamic data) : email = data['email'];

  toJson() => {"email": email};
}
