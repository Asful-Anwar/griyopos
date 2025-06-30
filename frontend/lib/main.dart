import 'package:flutter/material.dart';
import 'package:frontend/screens/login_screen.dart';
import 'package:frontend/screens/kasir_screen.dart';
import 'package:frontend/screens/daftar_produk_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Griyo POS Clone',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: DaftarProdukPage(),
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) =>  LoginScreen(),
        '/kasir': (context) =>  KasirScreen(),
        '/produk': (context) =>  DaftarProdukPage(),
      },
    );
  }
}
