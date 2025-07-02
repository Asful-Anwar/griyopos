import 'package:flutter/material.dart';
import '../models/produk.dart';
import '../services/produk_service.dart';

class ProdukFormPage extends StatefulWidget {
  final Produk? produk;

  const ProdukFormPage({Key? key, this.produk}) : super(key: key);

  @override
  _ProdukFormPageState createState() => _ProdukFormPageState();
}

class _ProdukFormPageState extends State<ProdukFormPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _hargaController = TextEditingController();
  final TextEditingController _stokController = TextEditingController();

  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    if (widget.produk != null) {
      _namaController.text = widget.produk!.nama;
      _hargaController.text = widget.produk!.harga.toString();
      _stokController.text = widget.produk!.stok.toString();
    }
  }

  Future<void> _simpanProduk() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);

    final nama = _namaController.text;
    final harga = int.parse(_hargaController.text);
    final stok = int.parse(_stokController.text);

    if (widget.produk == null) {
      await ProdukService.tambahProduk(nama, harga, stok);
    } else {
      await ProdukService.editProduk(widget.produk!.id, nama, harga, stok);
    }

    setState(() => _isSaving = false);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.produk != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Produk' : 'Tambah Produk'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _namaController,
                decoration: InputDecoration(labelText: 'Nama Produk'),
                validator: (value) =>
                    value!.isEmpty ? 'Nama tidak boleh kosong' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _hargaController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Harga'),
                validator: (value) =>
                    value!.isEmpty ? 'Harga tidak boleh kosong' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _stokController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Stok'),
                validator: (value) =>
                    value!.isEmpty ? 'Stok tidak boleh kosong' : null,
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: _isSaving ? null : _simpanProduk,
                child: Text(isEdit ? 'Simpan Perubahan' : 'Tambah Produk'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.green,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
