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
  List<Produk> keranjang = [];

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
      keranjang.add(produk);
    });
  }

  int getTotalHarga() {
    return keranjang.fold(0, (total, item) => total + item.harga);
  }

  void bayar() async {
    final total = getTotalHarga();
    final orderId = DateTime.now().millisecondsSinceEpoch.toString();

    try {
      final response = await http.post(
        Uri.parse('http://192.168.100.228:5000/bayar'),
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
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Pembayaran selesai.")),
                );
                setState(() {
                  keranjang.clear();
                });
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
        actions: [
          IconButton(icon: const Icon(Icons.settings), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          // Tombol atas
          Padding(
            padding: const EdgeInsets.all(8.0),
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

          // Layout Produk dan Struk
          Expanded(
            child: Row(
              children: [
                // Kiri: Produk
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
                          trailing: IconButton(
                            icon: const Icon(Icons.add_circle, color: Colors.green),
                            onPressed: () => tambahKeKeranjang(produk),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                // Kanan: Struk
                Expanded(
                  flex: 2,
                  child: Card(
                    margin: const EdgeInsets.all(8),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Struk Belanja",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const Divider(),
                          Expanded(
                            child: ListView.builder(
                              itemCount: keranjang.length,
                              itemBuilder: (context, index) {
                                final item = keranjang[index];
                                return ListTile(
                                  dense: true,
                                  title: Text(item.nama),
                                  trailing: Text("Rp${item.harga}"),
                                );
                              },
                            ),
                          ),
                          const Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Total:", style: TextStyle(fontSize: 16)),
                              Text(
                                "Rp${getTotalHarga()}",
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                                padding: const EdgeInsets.symmetric(vertical: 16),
                              ),
                            ),
                          )
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
