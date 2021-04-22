import 'package:json_annotation/json_annotation.dart';
import 'User.dart';

@JsonSerializable()
class LoginData {
  LoginData({this.user, this.token, this.success});

  User user;
  String token;
  bool success;


}
