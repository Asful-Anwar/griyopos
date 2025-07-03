import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/produk.dart';
import '../services/produk_service.dart';
import 'midtrans_page.dart';

class KasirScreen extends StatefulWidget {
  const KasirScreen({Key? key}) : super(key: key);

  @override
  State<KasirScreen> createState() => _KasirScreenState();
}

class _KasirScreenState extends State<KasirScreen> {
  List<Produk> produkList = [];
  Map<Produk, int> keranjang = {};

  @override
  void initState() {
    super.initState();
    fetchProduk();
  }

  void fetchProduk() async {
    final data = await ProdukService.fetchProduk();
    setState(() {
      produkList = data;
    });
  }

  void tambahKeKeranjang(Produk produk) {
    setState(() {
      keranjang.update(produk, (value) => value + 1, ifAbsent: () => 1);
    });
  }

  void kurangiDariKeranjang(Produk produk) {
    setState(() {
      if (keranjang.containsKey(produk)) {
        if (keranjang[produk]! > 1) {
          keranjang[produk] = keranjang[produk]! - 1;
        } else {
          keranjang.remove(produk);
        }
      }
    });
  }

  int getTotalHarga() {
    return keranjang.entries
        .map((entry) => entry.key.harga * entry.value)
        .fold(0, (a, b) => a + b);
  }

  int getTotalQty() {
    return keranjang.values.fold(0, (a, b) => a + b);
  }

  Future<void> simpanTransaksi(String orderId, int total) async {
    final keranjangData = keranjang.entries.map((entry) {
      return {
        'id': entry.key.id,
        'nama': entry.key.nama,
        'harga': entry.key.harga,
        'qty': entry.value,
      };
    }).toList();

    try {
      final res = await http.post(
        Uri.parse('http://192.168.1.6:5000/transaksi/simpan'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'order_id': orderId,
          'total': total,
          'metode_pembayaran': 'Midtrans',
          'keranjang': keranjangData,
        }),
      );

      if (res.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Transaksi berhasil disimpan.")),
        );
        setState(() => keranjang.clear());
      } else {
        throw Exception("Gagal simpan transaksi: ${res.body}");
      }
    } catch (e) {
      print("Error simpan transaksi: $e");
    }
  }

  void bayar() async {
    final total = getTotalHarga();
    final orderId = DateTime.now().millisecondsSinceEpoch.toString();

    try {
      final response = await http.post(
        Uri.parse('http://192.168.1.6:5000/bayar'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'order_id': orderId, 'total': total}),
      );

      if (response.statusCode == 200) {
        final snapToken = jsonDecode(response.body)['token'];
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => MidtransPage(
              snapToken: snapToken,
              onFinish: () {
                simpanTransaksi(orderId, total);
              },
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Gagal mendapatkan token Midtrans")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Terjadi kesalahan: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("Transaksi Baru"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.person),
                    label: const Text(""),
                    onPressed: () {},
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  icon: const Icon(Icons.qr_code),
                  label: const Text(""),
                  onPressed: () {},
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  icon: const Icon(Icons.delivery_dining),
                  label: const Text(""),
                  onPressed: () {},
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  icon: const Icon(Icons.search),
                  label: const Text(""),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                // Daftar Produk
                Expanded(
                  flex: 3,
                  child: Card(
                    margin: const EdgeInsets.all(8),
                    child: ListView.builder(
                      itemCount: produkList.length,
                      itemBuilder: (context, index) {
                        final produk = produkList[index];
                        return ListTile(
                          title: Text(produk.nama),
                          subtitle: Text("Rp${produk.harga}"),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove_circle, color: Colors.red),
                                onPressed: () => kurangiDariKeranjang(produk),
                              ),
                              IconButton(
                                icon: const Icon(Icons.add_circle, color: Colors.green),
                                onPressed: () => tambahKeKeranjang(produk),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),

                // Struk
                Expanded(
                  flex: 2,
                  child: Card(
                    margin: const EdgeInsets.all(8),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(child: Icon(Icons.store, size: 50)),
                          const Center(
                            child: Text(
                              "Karis Jaya Shop",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ),
                          const Center(
                            child: Text(
                              "Jl. Dr. Ir. H. Soekarno No.19, Medokan Semampir\nSurabaya",
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const Divider(thickness: 1),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [Text("2025-07-03"), Text("Karis")],
                          ),
                          const Divider(thickness: 1),
                          Expanded(
                            child: ListView.builder(
                              itemCount: keranjang.length,
                              itemBuilder: (context, index) {
                                final produk = keranjang.keys.elementAt(index);
                                final qty = keranjang[produk]!;
                                final total = produk.harga * qty;

                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 4.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${index + 1}. ${produk.nama}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text("$qty x ${produk.harga}"),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Text("Rp $total"),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          const Divider(thickness: 1),
                          Text("Total QTY : ${getTotalQty()}"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Sub Total"),
                              Text("Rp ${getTotalHarga()}"),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Total",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Rp ${getTotalHarga()}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: keranjang.isEmpty ? null : bayar,
                              icon: const Icon(Icons.payment),
                              label: const Text("Bayar"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
