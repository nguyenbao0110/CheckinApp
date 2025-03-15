import 'package:checkin_app/data/services/attendance_service.dart';
import 'package:checkin_app/data/services/auth_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupLocator () {
  getIt.registerSingleton<FlutterSecureStorage>(const FlutterSecureStorage());
  getIt.registerSingleton<AuthService>(AuthService(secureStorage: getIt<FlutterSecureStorage>()));
  getIt.registerSingleton<AttendanceService>(AttendanceService(secureStorage: getIt<FlutterSecureStorage>()));
}