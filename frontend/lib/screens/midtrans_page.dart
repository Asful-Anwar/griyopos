import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MidtransPage extends StatelessWidget {
  final String snapToken;

  const MidtransPage({Key? key, required this.snapToken}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final snapUrl = 'https://app.sandbox.midtrans.com/snap/v2/vtweb/$snapToken';

    // Fungsi untuk meluncurkan URL
    Future<void> _launchPayment() async {
      final uri = Uri.parse(snapUrl);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
        Navigator.pop(context); // kembali ke halaman sebelumnya setelah dibuka
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal membuka halaman Midtrans')),
        );
      }
    }

    // Jalankan saat build pertama
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _launchPayment();
    });

    return Scaffold(
      appBar: AppBar(
        title: Text("Memproses Pembayaran..."),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Mengalihkan ke Midtrans...', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
