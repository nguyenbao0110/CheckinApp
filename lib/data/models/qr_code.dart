class QrCode {
  int id;
  int nonce;

  QrCode({required this.id, required this.nonce});

  factory QrCode.fromJson(Map<String, dynamic> json) {
    return QrCode(id: json['id'], nonce: int.parse(json['nonce']));
  }
}
