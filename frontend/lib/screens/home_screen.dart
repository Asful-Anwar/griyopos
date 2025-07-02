import 'package:flutter/material.dart';
import 'produk_page.dart';
import 'transaksi_cepat_page.dart';
import 'laporan_page.dart';
import 'transaksi_page.dart';
import 'pelanggan_page.dart';
import 'master_page.dart';
import 'arus_kas_page.dart';
import 'pengeluaran_page.dart';
import 'katalog_page.dart';
import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  final String role;

  const HomeScreen({Key? key, required this.role}) : super(key: key);

  void _logout(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  Widget _squareButton(IconData icon, String label, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        height: 100,
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 32),
            const SizedBox(height: 8),
            Text(label, style: const TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isAdmin = role == 'admin';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Griyo POS'),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 24),
            // Tombol keranjang besar (Transaksi)
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => TransaksiPage()));
              },
              icon: const Icon(Icons.shopping_cart, size: 40),
              label: const Text('Transaksi', style: TextStyle(fontSize: 24)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
            ),

            const SizedBox(height: 24),

            // Tiga tombol utama
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _squareButton(Icons.table_bar, "Produk", Colors.blue, () {
                  if (isAdmin) {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => ProdukPage()));
                  }
                }),
                _squareButton(Icons.bolt, "Cepat", Colors.orange, () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => TransaksiCepatPage()));
                }),
                _squareButton(Icons.insert_chart, "Laporan", Colors.green, () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => LaporanPage()));
                }),
              ],
            ),

            const SizedBox(height: 12),

            // Tombol lainnya
            Wrap(
              alignment: WrapAlignment.center,
              children: [
                _squareButton(Icons.people, "Pelanggan", Colors.red, () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => PelangganPage()));
                }),
                _squareButton(Icons.apps, "Master", Colors.red, () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => MasterPage()));
                }),
                _squareButton(Icons.account_balance_wallet, "Arus Kas", Colors.blue, () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => ArusKasPage()));
                }),
                _squareButton(Icons.money_off, "Pengeluaran", Colors.red, () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => PengeluaranPage()));
                }),
                _squareButton(Icons.grid_view, "Katalog", Colors.red, () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => KatalogPage()));
                }),
                _squareButton(Icons.settings, "Pengaturan", Colors.blue, () {
                  // nanti dibuatkan
                }),
                _squareButton(Icons.logout, "Logout", Colors.grey, () => _logout(context)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
