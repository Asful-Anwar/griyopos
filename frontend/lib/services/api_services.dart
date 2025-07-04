import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/produk.dart';

class ApiService {
  static const String baseUrl = 'http://192.168.100.228:5000'; // Ganti IP jika perlu

  static Future<List<Produk>> fetchProduk() async {
    final response = await http.get(Uri.parse('$baseUrl/produk'));
    // print('Status code; ${response.statusCode}');
    // print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((json) => Produk.fromJson(json)).toList();
    } else {
      throw Exception('Gagal memuat produk');
    }
  }

  static Future<bool> kirimTransaksi(int total, Map<Produk, int> keranjang) async {
    final items = keranjang.entries.map((entry) => {
      "id": entry.key.id,
      "jumlah": entry.value,
    }).toList();

    final response = await http.post(
      Uri.parse('$baseUrl/transaksi'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'total': total,
        'items': items,
      }),
    );

    print('Status: ${response.statusCode}');
    print('Body: ${response.body}');

    return response.statusCode == 200;
  }
}
