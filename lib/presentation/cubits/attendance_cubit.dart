import 'package:checkin_app/app_exception.dart';
import 'package:checkin_app/data/models/attendance_request.dart';
import 'package:checkin_app/data/models/attendance_response.dart';
import 'package:checkin_app/data/services/attendance_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class AttendanceState {}

class AttendanceInitial extends AttendanceState {}

class AttendanceLoading extends AttendanceState {}

class AttendanceSuccess extends AttendanceState {
  final AttendanceResponse response;

  AttendanceSuccess(this.response);
}

class AttendanceFailure extends AttendanceState {
  final String message;

  AttendanceFailure(this.message);
}

class AttendanceCubit extends Cubit<AttendanceState> {
  final AttendanceService attendanceService;

  AttendanceCubit({required this.attendanceService})
      : super(AttendanceInitial());

  Future<void> attendance(AttendanceRequest request) async {
    emit(AttendanceLoading());
    try {
      final attendanceResponse = await attendanceService.attendance(request);
      emit(AttendanceSuccess(attendanceResponse));
    } catch (e) {
      if (e is AppException) {
        emit(AttendanceFailure(e.message));
      } else {
        emit(AttendanceFailure(e.toString()));
      }
    }
  }
}
