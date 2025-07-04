import 'package:flutter/material.dart';
import '../models/transaksi_model.dart';
import '../services/transaksi_service.dart';

class TransaksiPage extends StatefulWidget {
  const TransaksiPage({Key? key}) : super(key: key);

  @override
  State<TransaksiPage> createState() => _TransaksiPageState();
}

class _TransaksiPageState extends State<TransaksiPage> {
  late Future<List<Transaksi>> futureTransaksi;

  @override
  void initState() {
    super.initState();
    futureTransaksi = TransaksiService.fetchTransaksi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Riwayat Transaksi')),
      body: FutureBuilder<List<Transaksi>>(
        future: futureTransaksi,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final transaksiList = snapshot.data ?? [];

          if (transaksiList.isEmpty) {
            return const Center(child: Text('Belum ada transaksi'));
          }

          return ListView.builder(
            itemCount: transaksiList.length,
            itemBuilder: (context, index) {
              final transaksi = transaksiList[index];
              return Card(
                margin: const EdgeInsets.all(8),
                child: ExpansionTile(
                  title: Text(
                    "Order #${transaksi.orderId ?? '-'} - Rp${transaksi.total ?? 0}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(transaksi.createdAt ?? ''),
                  children: transaksi.items.map((item) {
                    return ListTile(
                      title: Text(item.namaProduk ?? '-'),
                      trailing: Text("${item.qty ?? 0} x ${item.harga ?? 0}"),
                    );
                  }).toList(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
