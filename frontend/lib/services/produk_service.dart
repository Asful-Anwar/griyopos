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
}