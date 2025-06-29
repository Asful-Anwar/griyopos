import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MidtransPage extends StatelessWidget {
  final String snapToken;

  const MidtransPage({Key? key, required this.snapToken}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final snapUrl = "https://app.sandbox.midtrans.com/snap/v2/vtweb/$snapToken";

    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(snapUrl));

    return Scaffold(
      appBar: AppBar(title: Text("Midtrans")),
      body: WebViewWidget(controller: controller),
    );
  }
}
