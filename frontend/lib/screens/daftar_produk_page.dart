import 'package:flutter/material.dart';
import '../models/produk.dart';
import '../services/produk_service.dart';

class DaftarProdukPage extends StatefulWidget {
  @override
  _DaftarProdukPageState createState() => _DaftarProdukPageState();
}

class _DaftarProdukPageState extends State<DaftarProdukPage> {
  late Future<List<Produk>> futureProduk;

  @override
  void initState() {
    super.initState();
    futureProduk = ProdukService.fetchProduk();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        title: Text('Produk'),
        backgroundColor: Colors.blue[800],
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            color: Colors.blue[700],
            padding: EdgeInsets.all(10),
            child: FutureBuilder<List<Produk>>(
              future: futureProduk,
              builder: (context, snapshot) {
                final jumlah = snapshot.hasData ? snapshot.data!.length : 0;
                return Text(
                  'Produk: $jumlah',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                );
              },
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Produk>>(
              future: futureProduk,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Terjadi kesalahan'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('Tidak ada data produk'));
                }
                final produkList = snapshot.data!;
                return ListView.separated(
                  itemCount: produkList.length,
                  separatorBuilder: (context, index) => Divider(height: 1),
                  itemBuilder: (context, index) {
                    final produk = produkList[index];
                    return ListTile(
                      title: Text(produk.nama),
                      subtitle: Text('Stok: ${produk.stok}'),
                      trailing: Text('Rp${produk.harga}', style: TextStyle(fontWeight: FontWeight.bold)),
                      onTap: () {
                        // navigasi ke detail jika diperlukan
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        child: Icon(Icons.add),
        onPressed: () {
          // Navigasi ke halaman tambah produk nanti
        },
      ),
    );
  }
}
