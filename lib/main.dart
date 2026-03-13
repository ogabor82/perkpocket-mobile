import 'package:flutter/material.dart';

void main() {
  runApp(const PerkPocketApp());
}

class PerkPocketApp extends StatelessWidget {
  const PerkPocketApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PerkPocket',
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        body: Center(
          child: Text('PerkPocket'),
        ),
      ),
    );
  }
}