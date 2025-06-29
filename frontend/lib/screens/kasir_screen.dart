import 'package:flutter/material.dart';
import '../models/produk.dart';
import '../services/api_services.dart';

class KasirScreen extends StatefulWidget {
  @override
  _KasirScreenState createState() => _KasirScreenState();
}

class _KasirScreenState extends State<KasirScreen> {
  late Future<List<Produk>> futureProduk;
  Map<Produk, int> keranjang = {};

  @override
  void initState() {
    super.initState();
    futureProduk = ApiService.fetchProduk();
  }

  void tambahKeKeranjang(Produk produk) {
    setState(() {
      if (keranjang.containsKey(produk)) {
        keranjang[produk] = keranjang[produk]! + 1;
      } else {
        keranjang[produk] = 1;
      }
    });
  }

  int getTotalHarga() {
    int total = 0;
    keranjang.forEach((produk, jumlah) {
      total += produk.harga * jumlah;
    });
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Kasir Griyo POS')),
      body: FutureBuilder<List<Produk>>(
        future: futureProduk,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final produkList = snapshot.data!;
            return GridView.builder(
              padding: EdgeInsets.all(10),
              itemCount: produkList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                final produk = produkList[index];
                return GestureDetector(
                  onTap: () => tambahKeKeranjang(produk),
                  child: Card(
                    elevation: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          produk.nama,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text("Rp ${produk.harga}"),
                        Text("Stok: ${produk.stok}"),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Gagal memuat produk'));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16),
        color: Colors.blue.shade50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total: Rp ${getTotalHarga()}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: keranjang.isEmpty
                  ? null
                  : () {
                      // Di tahap 3.3 akan kita buat fungsi checkout
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Checkout belum diimplementasi'),
                        ),
                      );
                    },
              child: Text("Checkout"),
            ),
          ],
        ),
      ),
    );
  }
}
