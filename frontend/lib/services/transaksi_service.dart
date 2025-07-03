import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/transaksi_model.dart';

class TransaksiService {
  static const baseUrl = 'http://192.168.1.6:5000';

  static Future<List<Transaksi>> fetchTransaksi() async {
    final response = await http.get(Uri.parse('$baseUrl/transaksi'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => Transaksi.fromJson(e)).toList();
    } else {
      throw Exception('Gagal memuat data transaksi');
    }
  }
}
