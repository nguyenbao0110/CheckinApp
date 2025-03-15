class AttendanceResponse {
  final String checkinTime;
  final String? checkoutTime;
  final String status;

  AttendanceResponse({
    required this.checkinTime,
    this.checkoutTime,
    required this.status,
  });

  factory AttendanceResponse.fromJson(Map<String, dynamic> json) {
    return AttendanceResponse(
      checkinTime: json["checkinTime"],
      checkoutTime: json["checkoutTime"],
      status: json["status"],
    );
  }
}
