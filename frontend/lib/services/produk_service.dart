import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/produk.dart';

class ProdukService {
  static const String baseUrl = 'http://192.168.100.228:5000';

  static Future<List<Produk>> fetchProduk() async {
    final response = await http.get(Uri.parse('$baseUrl/produk'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((item) => Produk.fromJson(item)).toList();
    } else {
      throw Exception('Gagal memuat data produk');
    }
  }

  static Future<bool> tambahProduk(String nama, int harga, int stok) async {
    final response = await http.post(
      Uri.parse('$baseUrl/produk'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'nama': nama,
        'harga': harga,
        'stok': stok,
      }),
    );

    return response.statusCode == 200;
  }

  static Future<bool> editProduk(int id, String nama, int harga, int stok) async {
    final response = await http.put(
      Uri.parse('$baseUrl/produk/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'nama': nama,
        'harga': harga,
        'stok': stok,
      }),
    );

    return response.statusCode == 200;
  }

  static Future<bool> hapusProduk(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/produk/$id'),
    );

    return response.statusCode == 200;
  }
}
