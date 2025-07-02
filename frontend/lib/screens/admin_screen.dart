import 'package:flutter/material.dart';

class AdminScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dashboard Admin")),
      body: Center(
        child: Text("Halaman Admin", style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
