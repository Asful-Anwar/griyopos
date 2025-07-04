import 'package:flutter/material.dart';
import 'package:frontend/screens/login_screen.dart';
import 'package:frontend/screens/kasir_screen.dart';
import 'package:frontend/screens/produk_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Griyo POS',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/transaksi-baru': (context) => const KasirScreen(),
        '/produk': (context) =>  ProdukPage(),
        '/login': (context) => const LoginScreen(),
      },
    );
  }
}
