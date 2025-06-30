// lib/services/produk_service.dart
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/produk.dart';

class ProdukService {
  static Future<List<Produk>> getProduk() async {
    final response = await http.get(Uri.parse('http://192.168.100.228:5000/produk'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Produk.fromJson(json)).toList();
    } else {
      throw Exception('Gagal memuat produk');
    }
  }
}
