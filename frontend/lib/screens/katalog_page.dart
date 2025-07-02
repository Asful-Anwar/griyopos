import 'package:flutter/material.dart';

class KatalogPage extends StatelessWidget {
  const KatalogPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Contoh data katalog produk
    final List<Map<String, dynamic>> katalogProduk = [
      {
        'nama': 'Nasi Goreng',
        'harga': 15000,
        'gambar': 'assets/images/no_image.png',
      },
      {
        'nama': 'Mie Ayam',
        'harga': 12000,
        'gambar': 'assets/images/no_image.png',
      },
      {
        'nama': 'Es Teh',
        'harga': 4000,
        'gambar': 'assets/images/no_image.png',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Katalog"),
        backgroundColor: Colors.orange[800],
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(16),
        itemCount: katalogProduk.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.7,
        ),
        itemBuilder: (context, index) {
          final item = katalogProduk[index];
          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  child: Image.asset(
                    item['gambar'],
                    height: 100,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Text(
                        item['nama'],
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Rp ${item['harga']}",
                        style: TextStyle(color: Colors.green[800]),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
