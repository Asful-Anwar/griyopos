class Produk {
  final int id;
  final String nama;
  final int harga;
  final int stok;

  Produk({
    required this.id,
    required this.nama,
    required this.harga,
    required this.stok,
  });

  factory Produk.fromJson(Map<String, dynamic> json) {
    return Produk(
      id: json['id'],
      nama: json['nama'],
      harga: json['harga'],
      stok: json['stok'],
    );
  }
}
