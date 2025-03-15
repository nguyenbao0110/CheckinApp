import 'dart:convert';

class AttendanceRequest {
  final int qrCodeId;
  final String nonce;
  final double latitude;
  final double longitude;

  AttendanceRequest({
    required this.qrCodeId,
    required this.nonce,
    required this.latitude,
    required this.longitude,
  });

  String toJson() {
    return jsonEncode({
      "qrCodeId": qrCodeId,
      "nonce": nonce,
      "latitude": latitude,
      "longitude": longitude
    });
  }
}
