import 'package:flutter/material.dart';

class ArtikelPage extends StatelessWidget {
  const ArtikelPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Artikel Page'), automaticallyImplyLeading: false),
      body: const Center(
        child: Text('Ini halaman artikel'),
      ),
    );
  }
}
