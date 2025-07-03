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
      id: int.tryParse(json['id'].toString()) ?? 0,
      nama: json['nama'] ?? '',
      harga: int.tryParse(json['harga'].toString()) ?? 0,
      stok: int.tryParse(json['stok'].toString()) ?? 0,
    );
  }
}
