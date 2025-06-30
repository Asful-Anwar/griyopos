// lib/models/produk.dart
class Produk {
  final int id;
  final String nama;
  final int harga;
  final int laba;

  Produk({
    required this.id,
    required this.nama,
    required this.harga,
    required this.laba,
  });

  factory Produk.fromJson(Map<String, dynamic> json) {
    return Produk(
      id: json['id'],
      nama: json['nama'],
      harga: json['harga'],
      laba: json['laba'],
    );
  }
}
