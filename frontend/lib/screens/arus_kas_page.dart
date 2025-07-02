import 'package:flutter/material.dart';

class ArusKasPage extends StatelessWidget {
  const ArusKasPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Data dummy contoh arus kas harian
    final List<Map<String, dynamic>> arusKas = [
      {
        'tanggal': '01 Juli 2025',
        'pemasukan': 250000,
        'pengeluaran': 100000,
        'saldo': 150000,
      },
      {
        'tanggal': '30 Juni 2025',
        'pemasukan': 180000,
        'pengeluaran': 50000,
        'saldo': 130000,
      },
      {
        'tanggal': '29 Juni 2025',
        'pemasukan': 210000,
        'pengeluaran': 90000,
        'saldo': 120000,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Arus Kas Harian"),
        backgroundColor: Colors.blue[900],
      ),
      body: ListView.separated(
        itemCount: arusKas.length,
        separatorBuilder: (context, index) => Divider(),
        itemBuilder: (context, index) {
          final kas = arusKas[index];
          return ListTile(
            title: Text(kas['tanggal'], style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Pemasukan: Rp ${kas['pemasukan']}"),
                Text("Pengeluaran: Rp ${kas['pengeluaran']}"),
              ],
            ),
            trailing: Text(
              "Saldo: Rp ${kas['saldo']}",
              style: TextStyle(
                color: Colors.green[700],
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        },
      ),
    );
  }
}
