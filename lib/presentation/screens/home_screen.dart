import 'package:checkin_app/data/services/attendance_service.dart';
import 'package:checkin_app/presentation/cubits/attendance_cubit.dart';
import 'package:checkin_app/presentation/screens/qr_scanner_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BlocProvider<AttendanceCubit>(
                                create: (context) => AttendanceCubit(
                                    attendanceService:
                                        GetIt.instance<AttendanceService>()),
                                child: const QRScannerScreen())));
                  },
                  child: const Text("Bấm dô đây"))
            ],
          )
        ],
      ),
    );
  }
}
