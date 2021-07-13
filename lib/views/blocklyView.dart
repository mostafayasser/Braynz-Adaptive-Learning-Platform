import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BlocklyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Blockly View",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: WebView(
          initialUrl: 'https://developers.google.com/blockly',
        ),
      ),
    );
  }
}
