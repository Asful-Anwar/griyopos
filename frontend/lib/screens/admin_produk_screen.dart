import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AdminProdukScreen extends StatefulWidget {
  @override
  _AdminProdukScreenState createState() => _AdminProdukScreenState();
}

class _AdminProdukScreenState extends State<AdminProdukScreen> {
  List produk = [];
  final namaCtrl = TextEditingController();
  final hargaCtrl = TextEditingController();
  int? editingId;

  Future<void> fetchProduk() async {
    final res = await http.get(Uri.parse('http://localhost:5000/produk'));
    if (res.statusCode == 200) {
      setState(() => produk = json.decode(res.body));
    }
  }

  Future<void> simpanProduk() async {
    final body = json.encode({
      "nama": namaCtrl.text,
      "harga": int.parse(hargaCtrl.text)
    });

    final url = editingId == null
        ? 'http://localhost:5000/produk'
        : 'http://localhost:5000/produk/$editingId';

    final res = editingId == null
        ? await http.post(Uri.parse(url), headers: {'Content-Type': 'application/json'}, body: body)
        : await http.put(Uri.parse(url), headers: {'Content-Type': 'application/json'}, body: body);

    if (res.statusCode == 200 || res.statusCode == 201) {
      namaCtrl.clear();
      hargaCtrl.clear();
      editingId = null;
      fetchProduk();
    }
  }

  Future<void> hapusProduk(int id) async {
    final res = await http.delete(Uri.parse('http://localhost:5000/produk/$id'));
    if (res.statusCode == 200) fetchProduk();
  }

  @override
  void initState() {
    super.initState();
    fetchProduk();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Kelola Produk")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: namaCtrl, decoration: InputDecoration(labelText: "Nama Produk")),
            TextField(controller: hargaCtrl, decoration: InputDecoration(labelText: "Harga"), keyboardType: TextInputType.number),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: simpanProduk,
              child: Text(editingId == null ? "Tambah Produk" : "Simpan Perubahan"),
            ),
            Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: produk.length,
                itemBuilder: (context, index) {
                  final p = produk[index];
                  return ListTile(
                    title: Text("${p['nama']}"),
                    subtitle: Text("Rp ${p['harga']}"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            setState(() {
                              namaCtrl.text = p['nama'];
                              hargaCtrl.text = p['harga'].toString();
                              editingId = p['id'];
                            });
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => hapusProduk(p['id']),
                        ),
                      ],
                    ),
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
