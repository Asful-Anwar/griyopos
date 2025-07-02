import 'package:flutter/material.dart';

class LaporanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> laporanList = [
      {'icon': Icons.bar_chart, 'label': 'Laporan Penjualan'},
      {'icon': Icons.shopping_bag, 'label': 'Laporan Produk'},
      {'icon': Icons.attach_money, 'label': 'Laporan Keuangan'},
      {'icon': Icons.calendar_today, 'label': 'Laporan Harian'},
      {'icon': Icons.analytics, 'label': 'Laporan Rangkuman'},
      {'icon': Icons.trending_up, 'label': 'Laporan Omzet'},
      {'icon': Icons.point_of_sale, 'label': 'Laporan Kasir'},
      {'icon': Icons.money, 'label': 'Laporan Pembayaran'},
      {'icon': Icons.sell, 'label': 'Laporan Diskon'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Laporan'),
        backgroundColor: Colors.blue[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: laporanList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemBuilder: (context, index) {
            final item = laporanList[index];
            return GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Fitur "${item['label']}" belum tersedia')),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade300),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 6,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(item['icon'], size: 40, color: Colors.blue),
                    SizedBox(height: 10),
                    Text(
                      item['label'],
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
