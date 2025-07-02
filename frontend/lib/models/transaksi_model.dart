class Transaksi {
  final int id;
  final String tanggal;
  final String jam;
  final int total;
  final String status;

  Transaksi({
    required this.id,
    required this.tanggal,
    required this.jam,
    required this.total,
    required this.status,
  });

  factory Transaksi.fromJson(Map<String, dynamic> json) {
    return Transaksi(
      id: json['id'],
      tanggal: json['tanggal'],
      jam: json['jam'],
      total: json['total'],
      status: json['status'],
    );
  }
}
