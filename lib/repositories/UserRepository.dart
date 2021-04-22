import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:forextainment/NetworkingClass.dart';
import 'package:forextainment/models/LoginData.dart';
import 'package:forextainment/models/User.dart';

class UserRepository {
  final FlutterSecureStorage storage = FlutterSecureStorage();

  Future<LoginData> authenticate({
    @required String username,
    @required String password,
  }) async {
    NetworkingClass server = NetworkingClass();
    final Map<String, dynamic> res = await server
        .post('/users/login', {'username': username, 'password': password});
    //TODO: format wordpress logindata properly
    LoginData data = LoginData(
      user: User(
//        id: res['data']['ID'],
        firstName: res['data']['first_name'],
        lastName: res['data']['last_name'],
        email: res['data']['user_email'],
        phone: res['data']['user_login'],
      ),
      token: 'mytoken',
    );
    return data;
  }

  Future<void> deleteToken() async {
    await storage.delete(key: 'token');
    return;
  }

  Future<void> saveUser(String user) async {
    await storage.write(key: 'user', value: user);
    return;
  }

  Future<User> getUser() async {
    String userStr = await storage.read(key: 'user');
    Map<String, dynamic> userJson = jsonDecode(userStr);
    return User(
      firstName: userJson['first_name'] ?? '',
      lastName: userJson['last_name'] ?? '',
      phone: userJson['phone'] ?? '',
      email: userJson['email'] ?? '',
      id: userJson['id'] ?? 0,
    );
  }

  Future<void> persistToken(String token) async {
    /// write to keystore/keychain
    await storage.write(key: 'token', value: token);
    return;
  }

  Future<bool> hasToken() async {
    bool _hasToken = await storage.read(key: 'token') != null;
    return _hasToken;
  }

  Future<String> getToken() async {
    return await storage.read(key: 'token');
  }
}
