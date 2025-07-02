import 'package:flutter/material.dart';

class TransaksiCepatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transaksi Cepat"),
        backgroundColor: Colors.blue[900],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            color: Colors.blue[700],
            padding: EdgeInsets.all(12),
            child: Text(
              "Pintasan Produk",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          Expanded(
            child: GridView.count(
              padding: EdgeInsets.all(12),
              crossAxisCount: 3,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              children: List.generate(9, (index) {
                return GestureDetector(
                  onTap: () {
                    // Fungsi jika shortcut ditekan
                  },
                  child: Card(
                    elevation: 4,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.shopping_cart, size: 40, color: Colors.blue),
                        SizedBox(height: 8),
                        Text("Produk ${index + 1}",
                            style: TextStyle(fontSize: 14)),
                        Text("Rp 0", style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
