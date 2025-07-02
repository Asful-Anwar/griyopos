import 'package:flutter/material.dart';
import '../models/transaksi_model.dart';
import '../services/transaksi_service.dart';

class TransaksiPage extends StatefulWidget {
  @override
  _TransaksiPageState createState() => _TransaksiPageState();
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
      appBar: AppBar(
        title: Text("Transaksi"),
        backgroundColor: Colors.blue[800],
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
          IconButton(icon: Icon(Icons.settings), onPressed: () {}),
        ],
      ),
      body: FutureBuilder<List<Transaksi>>(
        future: futureTransaksi,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final transaksiList = snapshot.data!;
            return ListView.builder(
              itemCount: transaksiList.length,
              itemBuilder: (context, index) {
                final tx = transaksiList[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(tx.tanggal),
                        Text("Rp${tx.total}", style: TextStyle(color: Colors.blue)),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${tx.jam}  •  Product: 1"),
                        Text(
                          tx.status == "Lunas" ? "Lunas" : "Antri",
                          style: TextStyle(
                            color: tx.status == "Lunas" ? Colors.green : Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    trailing: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.red[700],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text("ANTRI #${tx.id}", style: TextStyle(color: Colors.white)),
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("Gagal memuat data transaksi"));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
