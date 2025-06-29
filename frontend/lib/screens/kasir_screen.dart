import 'package:flutter/material.dart';
import '../models/produk.dart';
import '../services/api_services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'midtrans_page.dart';


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
      keranjang.update(produk, (jumlah) => jumlah + 1, ifAbsent: () => 1);
    });
  }

  void checkout() async {
    final sukses = await ApiService.kirimTransaksi(getTotalHarga(), keranjang);
    if (sukses) {
      setState(() {
        keranjang.clear();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Transaksi berhasil')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal transaksi')),
      );
    }
  }

  void bayarDenganMidtrans() async {
    final orderId = DateTime.now().millisecondsSinceEpoch.toString();

    final response = await http.post(
      Uri.parse('${ApiService.baseUrl}/bayar'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'order_id': orderId,
        'total': getTotalHarga(),
      }),
    );

    if (response.statusCode == 200) {
      final snapToken = json.decode(response.body)['token'];
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MidtransPage(snapToken: snapToken),
        ),
      );
    }else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal memuat Midtrans'))
      );
    }
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
      body: Row(
        children: [
          // Sidebar
          NavigationRail(
            selectedIndex: 0,
            onDestinationSelected: (index) {},
            labelType: NavigationRailLabelType.all,
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.point_of_sale),
                label: Text('Kasir'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.inventory),
                label: Text('Produk'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.receipt_long),
                label: Text('Transaksi'),
              ),
            ],
          ),

          // Grid Produk
          Expanded(
            flex: 3,
            child: FutureBuilder<List<Produk>>(
              future: futureProduk,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final produkList = snapshot.data!;
                  return GridView.builder(
                    padding: EdgeInsets.all(16),
                    itemCount: produkList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1.2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemBuilder: (context, index) {
                      final produk = produkList[index];
                      return GestureDetector(
                        onTap: () => tambahKeKeranjang(produk),
                        child: Card(
                          color: Colors.white,
                          elevation: 4,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          child: Padding(
                            padding: EdgeInsets.all(12),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.fastfood, size: 40, color: Colors.blue),
                                SizedBox(height: 8),
                                Text(produk.nama, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                Text("Rp ${produk.harga}"),
                                Text("Stok: ${produk.stok}"),
                              ],
                            ),
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
          ),

          // Keranjang
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.grey.shade100,
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Text('Keranjang', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Divider(),
                  Expanded(
                    child: ListView(
                      children: keranjang.entries.map((entry) {
                        return ListTile(
                          title: Text(entry.key.nama),
                          subtitle: Text('x${entry.value}'),
                          trailing: Text("Rp ${entry.key.harga * entry.value}"),
                        );
                      }).toList(),
                    ),
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total:', style: TextStyle(fontSize: 18)),
                      Text("Rp ${getTotalHarga()}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: keranjang.isEmpty ? null : bayarDenganMidtrans,
                    icon: Icon(Icons.credit_card),
                    label: Text('Bayar Online'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                      backgroundColor: Colors.orange,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}