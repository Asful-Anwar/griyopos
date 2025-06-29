import 'package:flutter/material.dart';
import 'package:frontend/screens/login_screen.dart';
import 'screens/kasir_screen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: LoginScreen(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Griyo POS Clone',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: KasirScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
