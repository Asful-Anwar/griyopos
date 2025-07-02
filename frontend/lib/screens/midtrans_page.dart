import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MidtransPage extends StatelessWidget {
  final String snapToken;
  final VoidCallback onFinish;

  const MidtransPage({
    Key? key,
    required this.snapToken,
    required this.onFinish,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final snapUrl = 'https://app.sandbox.midtrans.com/snap/v2/vtweb/$snapToken';

    Future<void> _launchPayment() async {
      final uri = Uri.parse(snapUrl);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
        onFinish(); // ⬅️ Panggil callback ketika selesai membuka browser
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal membuka halaman Midtrans')),
        );
      }
    }

    // Jalankan saat halaman selesai dibangun
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _launchPayment();
    });

    return Scaffold(
      appBar: AppBar(
        title: Text("Mengalihkan ke Midtrans"),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text("Mengalihkan ke halaman pembayaran..."),
          ],
        ),
      ),
    );
  }
}
