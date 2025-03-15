import 'dart:convert';
import 'package:checkin_app/data/models/attendance_request.dart';
import 'package:checkin_app/presentation/cubits/attendance_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScannerScreen extends StatefulWidget {
  const QRScannerScreen({super.key});

  @override
  State<QRScannerScreen> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  bool isScanned = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          "Scan QR Code",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
      ),
      body: BlocConsumer<AttendanceCubit, AttendanceState>(
        listener: (context, state) {
          if (state is AttendanceSuccess) {
            _showResultDialog("Success", "Check-in successful: ${state.response.status}");
          } else if (state is AttendanceFailure) {
            _showResultDialog("Error", "Check-in failed: ${state.message}");
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              // Scanner
              MobileScanner(
                onDetect: (capture) async {
                  if (!isScanned) {
                    setState(() => isScanned = true);

                    final barcode = capture.barcodes.firstOrNull;
                    if (barcode?.rawValue != null) {
                      _handleQRCode(barcode!.rawValue!, context);
                    }
                  }
                },
              ),

              // Scanner overlay
              Center(
                child: Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue, width: 3),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              // Instruction text
              if (!isScanned)
                Positioned(
                  bottom: 100,
                  left: 20,
                  right: 20,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      "Align the QR code within the frame",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),

              // Loading overlay
              if (state is AttendanceLoading)
                Container(
                  color: Colors.black.withOpacity(0.7),
                  child: const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  void _handleQRCode(String qrData, BuildContext context) async {
    try {
      final qrJson = jsonDecode(qrData);
      final position = await _getCurrentLocation();
      final request = AttendanceRequest(
        qrCodeId: qrJson['id'],
        nonce: qrJson['nonce'],
        latitude: position.latitude,
        longitude: position.longitude,
      );

      context.read<AttendanceCubit>().attendance(request);
    } catch (e) {
      _showResultDialog("Error", "Invalid QR Code!");
    }
  }

  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      throw Exception("Location service is disabled. Please enable GPS!");
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception("Location permission denied!");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception("Location permission is permanently denied. Please enable it in settings!");
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  void _showResultDialog(String title, String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        actions: [
          TextButton(
            onPressed: () {
              setState(() => isScanned = false);
              Navigator.of(context).pop();
            },
            child: const Text("OK", style: TextStyle(color: Colors.blue)),
          ),
        ],
      ),
    );
  }
}