// lib/screens/transaksi_page.dart

import 'package:flutter/material.dart';

class TransaksiPage extends StatelessWidget {
  const TransaksiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaksi'),
        backgroundColor: Colors.blue[800],
        actions: const [
          Icon(Icons.search),
          SizedBox(width: 12),
          Icon(Icons.settings),
          SizedBox(width: 12),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: [
          _buildTransaksiCard(
            tanggal: '2 JUL 2025',
            jam: '11:21',
            total: 1000,
            nomor: '#1',
            produkList: [
              {'nama': 'Product 1', 'jumlah': 1}
            ],
            status: 'Lunas',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red[800],
        child: const Icon(Icons.shopping_cart_checkout),
        onPressed: () {
          // Arahkan ke halaman transaksi baru
          Navigator.pushNamed(context, '/transaksi-baru');
        },
      ),
    );
  }

  Widget _buildTransaksiCard({
    required String tanggal,
    required String jam,
    required int total,
    required String nomor,
    required List<Map<String, dynamic>> produkList,
    required String status,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(tanggal, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text("Rp$total", style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Rp$total", style: const TextStyle(color: Colors.blue)),
                Text(jam),
                Text(nomor),
              ],
            ),
            const SizedBox(height: 4),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: produkList
                  .map((produk) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${produk['nama']} : ${produk['jumlah']}'),
                        ],
                      ))
                  .toList(),
            ),
            const SizedBox(height: 2),
            Text(status, style: const TextStyle(color: Colors.green)),
            const SizedBox(height: 6),
            Align(
              alignment: Alignment.centerLeft,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[800],
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                ),
                child: const Text('ANTRI #1', style: TextStyle(fontSize: 12)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
