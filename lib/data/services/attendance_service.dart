import 'dart:convert';

import 'package:checkin_app/app_exception.dart';
import 'package:checkin_app/constants.dart';
import 'package:checkin_app/data/models/attendance_request.dart';
import 'package:checkin_app/data/models/attendance_response.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AttendanceService {
  final FlutterSecureStorage secureStorage;

  AttendanceService({required this.secureStorage});

  Future<AttendanceResponse> attendance(AttendanceRequest request) async {
    final token = await secureStorage.read(key: 'token');
    if (token == null) {
      throw AppException(message: 'Not logged in', statusCode: 400);
    }

    final response = await http.post(
        Uri.parse('$apiUrl/api/attendance'),
        headers: {
          'content-type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: request.toJson()
    );

    final responseBody = jsonDecode(response.body);
    if (response.statusCode != 200) {
      throw AppException(
          message: responseBody['message'], statusCode: responseBody['code']);
    }

    return AttendanceResponse.fromJson(responseBody);
  }
}
