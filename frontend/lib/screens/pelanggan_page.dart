import 'package:flutter/material.dart';

class PelangganPage extends StatefulWidget {
  const PelangganPage({Key? key}) : super(key: key);

  @override
  State<PelangganPage> createState() => _PelangganPageState();
}

class _PelangganPageState extends State<PelangganPage> {
  List<Map<String, String>> pelanggan = [
    {"nama": "Andi", "telp": "081234567890"},
    {"nama": "Budi", "telp": "082233445566"},
    {"nama": "Citra", "telp": "083312345678"},
  ];

  final _namaController = TextEditingController();
  final _telpController = TextEditingController();

  void _tambahPelanggan() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Tambah Pelanggan"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _namaController,
              decoration: InputDecoration(labelText: "Nama"),
            ),
            TextField(
              controller: _telpController,
              decoration: InputDecoration(labelText: "No. Telepon"),
              keyboardType: TextInputType.phone,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _namaController.clear();
              _telpController.clear();
            },
            child: Text("Batal"),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                pelanggan.add({
                  "nama": _namaController.text,
                  "telp": _telpController.text,
                });
              });
              Navigator.pop(context);
              _namaController.clear();
              _telpController.clear();
            },
            child: Text("Simpan"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pelanggan"),
        backgroundColor: Colors.blue[800],
        actions: [
          IconButton(
            onPressed: _tambahPelanggan,
            icon: Icon(Icons.person_add),
            tooltip: "Tambah Pelanggan",
          ),
        ],
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(12),
        separatorBuilder: (_, __) => Divider(),
        itemCount: pelanggan.length,
        itemBuilder: (context, index) {
          final data = pelanggan[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue.shade300,
              child: Icon(Icons.person, color: Colors.white),
            ),
            title: Text(data['nama'] ?? ''),
            subtitle: Text(data['telp'] ?? ''),
            trailing: Icon(Icons.chevron_right),
          );
        },
      ),
    );
  }
}
