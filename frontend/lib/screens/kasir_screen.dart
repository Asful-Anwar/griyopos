// lib/screens/kasir_screen.dart

import 'package:flutter/material.dart';

class KasirScreen extends StatefulWidget {
  const KasirScreen({Key? key}) : super(key: key);

  @override
  _KasirScreenState createState() => _KasirScreenState();
}

class _KasirScreenState extends State<KasirScreen> {
  final List<Map<String, dynamic>> produkList = [
    {"nama": "Produk 1", "harga": 1000},
    {"nama": "Produk 2", "harga": 2500},
    {"nama": "Produk 3", "harga": 3500},
  ];

  List<Map<String, dynamic>> keranjang = [];

  void tambahKeKeranjang(Map<String, dynamic> produk) {
    setState(() {
      keranjang.add(produk);
    });
  }

  int get totalHarga =>
      keranjang.fold(0, (sum, item) => sum + (item['harga'] as int));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kasir'),
      ),
      body: Row(
        children: [
          // Kiri: List Produk
          Expanded(
            flex: 2,
            child: ListView.builder(
              itemCount: produkList.length,
              itemBuilder: (context, index) {
                final produk = produkList[index];
                return ListTile(
                  title: Text(produk['nama']),
                  subtitle: Text('Rp${produk['harga']}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () => tambahKeKeranjang(produk),
                  ),
                );
              },
            ),
          ),
          // Kanan: Struk dan total
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.grey[100],
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Struk Belanja',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: keranjang.length,
                      itemBuilder: (context, index) {
                        final item = keranjang[index];
                        return ListTile(
                          title: Text(item['nama']),
                          trailing: Text('Rp${item['harga']}'),
                        );
                      },
                    ),
                  ),
                  const Divider(),
                  Text(
                    'Total: Rp$totalHarga',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      // nanti: integrasi Midtrans
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Pembayaran belum diintegrasi")),
                      );
                    },
                    child: const Text('Bayar Sekarang'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
