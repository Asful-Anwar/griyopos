import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'kasir_screen.dart';
import 'admin_screen.dart';
import 'package:frontend/screens/admin_produk_screen.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final userCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  Future<void> login() async {
    print("Coba Login ...");
    final res = await http.post(
      Uri.parse('http://localhost:5000/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'username': userCtrl.text, 'password': passCtrl.text}),
    );

    print("Status code: ${res.statusCode}");
    print("Body: ${res.body}");

    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      final role = data['role'];

      if (role == 'admin') {
        print("Login sebagai admin");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => HomeScreen(role: role)),
        );

        //TODO:arahkan ke halaman admin
      } else {
        print("Login sebagai kasir");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => KasirScreen()),
        );
      }
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Login gagal")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/download-removebg-preview.png',
              height: 100,
            ),
            SizedBox(height: 24),
            Text("Login", style: TextStyle(fontSize: 24)),
            TextField(
              controller: userCtrl,
              decoration: InputDecoration(labelText: "Username"),
            ),
            TextField(
              controller: passCtrl,
              decoration: InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: login, child: Text("Login")),
          ],
        ),
      ),
    );
  }
}
