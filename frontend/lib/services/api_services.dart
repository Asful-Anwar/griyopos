import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/produk.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:5000';

  static Future<List<Produk>> fetchProduk() async {
    final response = await http.get(Uri.parse('$baseUrl/produk'));

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((json) => Produk.fromJson(json)).toList();
    } else {
      throw Exception('Gagal memuat produk');
    }
  }
}
