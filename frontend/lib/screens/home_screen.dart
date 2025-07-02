import 'package:flutter/material.dart';
import 'kasir_screen.dart';
import 'admin_produk_screen.dart';
import 'admin_riwayat_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  final String role;
  const HomeScreen({required this.role});

  void _logout(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isAdmin = role == 'admin';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text("Griyo POS"),
        actions: [
          Icon(Icons.person, size: 28),
          SizedBox(width: 16),
          Icon(Icons.help_outline, size: 28),
          SizedBox(width: 16),
          Icon(Icons.settings, size: 28),
          SizedBox(width: 16),
        ],
      ),
      drawer: Drawer(child: ListView(children: [DrawerHeader(child: Text("Menu"))])),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () {},
                  child: Text("TANPA IKLAN"),
                ),
              ),
              SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => KasirScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(40),
                  ),
                  child: Icon(Icons.add_shopping_cart, size: 48, color: Colors.white),
                ),
              ),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _iconMenu(Icons.attach_money, "Transaksi", () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => KasirScreen()));
                  }),
                  _iconMenu(Icons.pedal_bike, "Cepat", () {
                    // Sementara kosong
                  }),
                  _iconMenu(Icons.bar_chart, "Laporan", () {
                    if (isAdmin) {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => AdminRiwayatScreen()));
                    }
                  }),
                ],
              ),
              SizedBox(height: 32),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _squareButton(Icons.table_bar, "Produk", Colors.blue, () {
                    if (isAdmin) Navigator.push(context, MaterialPageRoute(builder: (_) => AdminProdukScreen()));
                  }),
                  _squareButton(Icons.people, "Pelanggan", Colors.red, () {}),
                  _squareButton(Icons.apps, "Master", Colors.red, () {}),
                  _squareButton(Icons.account_balance_wallet, "Arus Kas", Colors.blue, () {}),
                  _squareButton(Icons.money_off, "Pengeluaran", Colors.red, () {}),
                  _squareButton(Icons.grid_view, "Katalog", Colors.red, () {}),
                  _squareButton(Icons.settings, "Pengaturan", Colors.blue, () {}),
                  _squareButton(Icons.logout, "Logout", Colors.grey, () => _logout(context)),
                ],
              ),
              SizedBox(height: 32),
              Text("No chart data available.", style: TextStyle(color: Colors.orange)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _iconMenu(IconData icon, String label, VoidCallback onTap) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.blue,
          child: IconButton(icon: Icon(icon, color: Colors.white), onPressed: onTap),
        ),
        SizedBox(height: 6),
        Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _squareButton(IconData icon, String label, Color color, VoidCallback onTap) {
    return SizedBox(
      width: 100,
      height: 100,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        onPressed: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32),
            SizedBox(height: 8),
            Text(label, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
