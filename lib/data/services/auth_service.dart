import 'dart:convert';

import 'package:checkin_app/constants.dart';
import 'package:checkin_app/app_exception.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService {
  FlutterSecureStorage secureStorage;

  AuthService({required this.secureStorage});

  Future<void> authenticate ({required String username,required String password}) async {
    final requestBody = {
      "username": username,
      "password": password
    };
    final response =  await http.post(
        Uri.parse('$apiUrl/api/auth'),
        headers: {
          "content-type": "application/json"
        },
        body: jsonEncode(requestBody)
    );
    final responseBody = jsonDecode(response.body);
    if(response.statusCode != 200) {
      throw AppException(
          message: responseBody['message'],
          statusCode: int.parse(responseBody['code'])
      );
    }
    final token = responseBody['data']['accessToken'];
    await secureStorage.write(key: 'token', value: token);
  }

  Future<void> logout () async {
    final response = await http.post(Uri.parse('$apiUrl/api/auth/logout'));
    final responseBody = jsonDecode(response.body);
    if(response.statusCode != 200) {
      throw AppException(
          message: responseBody['message'],
          statusCode: int.parse(responseBody['code'])
      );
    }
    await secureStorage.delete(key: 'token');
  }

  Future<void> refreshToken () async {
    final token = await secureStorage.read(key: 'token');
    final requestBody = {
      "token": token
    };
    final response = await http.post(
        Uri.parse('$apiUrl/api/auth/refresh-token'),
        headers: {
          "content-type": "application/json"
        },
        body: jsonEncode(requestBody)
    );
    final responseBody = jsonDecode(response.body);
    if(response.statusCode != 200) {
      throw AppException(
          message: responseBody['message'],
          statusCode: int.parse(responseBody['code'])
      );
    }
    await secureStorage.write(key: 'token', value: responseBody['accessToken']);
  }
}