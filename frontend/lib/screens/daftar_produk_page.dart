import 'package:flutter/material.dart';

class DaftarProdukPage extends StatelessWidget {
  final List<Map<String, dynamic>> produkList = [
    {
      'nama': 'Roti Bakar',
      'harga': 20000,
    },
    {
      'nama': 'Kopi Hitam',
      'harga': 5000,
    },
    {
      'nama': 'Teh Poci',
      'harga': 5000,
    },
    {
      'nama': 'Kue Pancong',
      'harga': 15000,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kelola Produk"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: Text("Nama Produk",
                        style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text("Harga",
                        style: TextStyle(fontWeight: FontWeight.bold))),
              ],
            ),
            Divider(),
            ElevatedButton(
              onPressed: () {
                // navigasi ke tambah produk
              },
              child: Text("Tambah Produk"),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: produkList.length,
                itemBuilder: (context, index) {
                  final produk = produkList[index];
                  return Row(
                    children: [
                      Expanded(child: Text(produk['nama'])),
                      Expanded(child: Text("Rp ${produk['harga']}")),
                      IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                      IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
