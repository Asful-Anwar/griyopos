// lib/screens/home_screen.dart

import 'package:flutter/material.dart';
import 'produk_page.dart';
import 'pelanggan_page.dart';
import 'master_page.dart';
import 'arus_kas_page.dart';
import 'pengeluaran_page.dart';
import 'katalog_page.dart';
import 'transaksi_page.dart';
import 'transaksi_cepat_page.dart';
import 'laporan_page.dart';

class HomeScreen extends StatelessWidget {
  final String role;
  const HomeScreen({Key? key, required this.role}) : super(key: key);

  bool get isAdmin => role == 'admin';

  void _logout(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/login');
  }

  Widget _circleButton(IconData icon, String label, Color color, VoidCallback onTap) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: CircleAvatar(
            radius: 30,
            backgroundColor: color,
            child: Icon(icon, color: Colors.white),
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12))
      ],
    );
  }

  Widget _squareButton(IconData icon, String label, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
            child: Icon(icon, color: Colors.white),
          ),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 12))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Griyo POS'),
        backgroundColor: Colors.blue[800],
        actions: const [
          Icon(Icons.person),
          SizedBox(width: 8),
          Icon(Icons.help_outline),
          SizedBox(width: 8),
          Icon(Icons.settings),
          SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red[800]),
            child: const Text('TANPA IKLAN'),
          ),
          const SizedBox(height: 8),
          Center(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => TransaksiCepatPage()),
                );
              },
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.red[800],
                child: const Icon(Icons.add_shopping_cart, color: Colors.white, size: 40),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _circleButton(Icons.attach_money, "Transaksi", Colors.blue, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const TransaksiPage()),
                );
              }),
              _circleButton(Icons.directions_bike, "Cepat", Colors.blue, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => TransaksiCepatPage()),
                );
              }),
              _circleButton(Icons.bar_chart, "Laporan", Colors.blue, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => LaporanPage()),
                );
              }),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 16,
            runSpacing: 16,
            children: [
              _squareButton(Icons.table_bar, "Produk", Colors.blue, () {
                if (isAdmin) Navigator.push(context, MaterialPageRoute(builder: (_) => ProdukPage()));
              }),
              _squareButton(Icons.people, "Pelanggan", Colors.red, () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const PelangganPage()));
              }),
              _squareButton(Icons.apps, "Master", Colors.red, () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const MasterPage()));
              }),
              _squareButton(Icons.account_balance_wallet, "Arus Kas", Colors.blue, () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const ArusKasPage()));
              }),
              _squareButton(Icons.money_off, "Pengeluaran", Colors.red, () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const PengeluaranPage()));
              }),
              _squareButton(Icons.grid_view, "Katalog", Colors.red, () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const KatalogPage()));
              }),
              _squareButton(Icons.settings, "Pengaturan", Colors.blue, () {}),
              _squareButton(Icons.logout, "Logout", Colors.grey, () => _logout(context)),
            ],
          ),
          const SizedBox(height: 16),
          const Expanded(
            child: Center(
              child: Text(
                'No chart data available.',
                style: TextStyle(color: Colors.orangeAccent),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
