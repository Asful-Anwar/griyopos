import 'package:flutter/material.dart';
import '../models/produk.dart';
import '../services/produk_service.dart';
import 'produk_form_page.dart';

class ProdukPage extends StatefulWidget {
  @override
  _ProdukPageState createState() => _ProdukPageState();
}

class _ProdukPageState extends State<ProdukPage> {
  late Future<List<Produk>> futureProduk;

  @override
  void initState() {
    super.initState();
    futureProduk = ProdukService.fetchProduk();
  }

  void _refreshProduk() {
    setState(() {
      futureProduk = ProdukService.fetchProduk();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Produk'),
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder<List<Produk>>(
        future: futureProduk,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Gagal memuat data'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Belum ada produk'));
          }

          final produkList = snapshot.data!;

          return ListView.separated(
            itemCount: produkList.length,
            separatorBuilder: (_, __) => Divider(),
            itemBuilder: (context, index) {
              final produk = produkList[index];
              return ListTile(
                title: Text(produk.nama),
                subtitle: Text('Stok: ${produk.stok}'),
                trailing: Text('Rp ${produk.harga}'),
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ProdukFormPage(produk: produk),
                    ),
                  );
                  _refreshProduk();
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => ProdukFormPage()),
          );
          _refreshProduk();
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
}
