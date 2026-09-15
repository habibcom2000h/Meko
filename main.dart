import 'package:flutter/material.dart';

void main() {
  runApp(const MekoApp());
}

class MekoApp extends StatelessWidget {
  const MekoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meko',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Meko'),
          centerTitle: true,
        ),
        body: const Center(
          child: Text(
            'مرحبًا بك في Meko 🎙️',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
