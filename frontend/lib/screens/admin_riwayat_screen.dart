import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AdminRiwayatScreen extends StatefulWidget {
  @override
  _AdminRiwayatScreenState createState() => _AdminRiwayatScreenState();
}

class _AdminRiwayatScreenState extends State<AdminRiwayatScreen> {
  List transaksi = [];

  Future<void> fetchRiwayat() async {
    final res = await http.get(Uri.parse('http://localhost:5000/transaksi'));
    if (res.statusCode == 200) {
      setState(() => transaksi = json.decode(res.body));
    }
  }

  @override
  void initState() {
    super.initState();
    fetchRiwayat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Riwayat Transaksi")),
      body: ListView.builder(
        itemCount: transaksi.length,
        itemBuilder: (context, index) {
          final t = transaksi[index];
          return ExpansionTile(
            title: Text("ID: ${t['transaksi_id']} • Rp ${t['total']}"),
            subtitle: Text("${t['created_at']}"),
            children: (t['items'] as List).map((item) {
              return ListTile(
                title: Text(item['nama']),
                trailing: Text("x${item['jumlah']} • Rp ${item['harga']}"),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
