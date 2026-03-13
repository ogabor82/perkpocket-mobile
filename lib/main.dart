import 'package:flutter/material.dart';
import 'theme/app_theme.dart';

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
      theme: AppTheme.light,
      home: const Scaffold(
        body: Center(
          child: Text('PerkPocket'),
        ),
      ),
    );
  }
}