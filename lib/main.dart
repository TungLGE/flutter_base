import 'package:di_demo/di/di.dart';
import 'package:di_demo/presentation/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

String env = Environment.prod;

void main() {
  configureDependencies(env: env);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}
