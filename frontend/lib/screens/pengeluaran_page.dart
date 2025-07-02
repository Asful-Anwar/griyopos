import 'package:flutter/material.dart';

class PengeluaranPage extends StatelessWidget {
  const PengeluaranPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Data dummy contoh pengeluaran
    final List<Map<String, dynamic>> dataPengeluaran = [
      {
        'tanggal': '01 Juli 2025',
        'deskripsi': 'Beli bahan baku',
        'jumlah': 70000,
      },
      {
        'tanggal': '30 Juni 2025',
        'deskripsi': 'Bayar listrik',
        'jumlah': 50000,
      },
      {
        'tanggal': '29 Juni 2025',
        'deskripsi': 'Perbaikan mesin',
        'jumlah': 40000,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Pengeluaran"),
        backgroundColor: Colors.red[700],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              onPressed: () {
                // Tambahkan fungsi tambah pengeluaran jika diperlukan
              },
              icon: Icon(Icons.add),
              label: Text("Tambah Pengeluaran"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: dataPengeluaran.length,
              separatorBuilder: (_, __) => Divider(),
              itemBuilder: (context, index) {
                final pengeluaran = dataPengeluaran[index];
                return ListTile(
                  title: Text(pengeluaran['deskripsi']),
                  subtitle: Text(pengeluaran['tanggal']),
                  trailing: Text(
                    "Rp ${pengeluaran['jumlah']}",
                    style: TextStyle(
                      color: Colors.red[800],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
