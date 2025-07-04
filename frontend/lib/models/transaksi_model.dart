class Transaksi {
  final String? orderId;
  final int? total;
  final String? metodePembayaran;
  final String? createdAt;
  final List<TransaksiItem> items;

  Transaksi({
    this.orderId,
    this.total,
    this.metodePembayaran,
    this.createdAt,
    required this.items,
  });

  factory Transaksi.fromJson(Map<String, dynamic> json) {
    var itemsFromJson = json['items'] as List? ?? [];
    List<TransaksiItem> itemList =
        itemsFromJson.map((item) => TransaksiItem.fromJson(item)).toList();

    return Transaksi(
      orderId: json['order_id']?.toString(),
      total: int.tryParse(json['total'].toString()),
      metodePembayaran: json['metode_pembayaran']?.toString(),
      createdAt: json['created_at']?.toString(),
      items: itemList,
    );
  }
}

class TransaksiItem {
  final String? namaProduk;
  final int? qty;
  final int? harga;

  TransaksiItem({this.namaProduk, this.qty, this.harga});

  factory TransaksiItem.fromJson(Map<String, dynamic> json) {
    return TransaksiItem(
      namaProduk: json['nama_produk']?.toString(),
      qty: int.tryParse(json['qty'].toString()),
      harga: int.tryParse(json['harga'].toString()),
    );
  }
}
