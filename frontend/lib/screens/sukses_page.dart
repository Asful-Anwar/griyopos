import 'package:flutter/material.dart';

class SuksesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pembayaran Berhasil")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle, size: 80, color: Colors.green),
            SizedBox(height: 16),
            Text('Pembayaran berhasil!', style: TextStyle(fontSize: 20)),
            SizedBox(height: 24),
            ElevatedButton(
              child: Text('Kembali ke Kasir'),
              onPressed: () => Navigator.popUntil(context, ModalRoute.withName('/')),
            ),
          ],
        ),
      ),
    );
  }
}
