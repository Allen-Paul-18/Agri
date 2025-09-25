import 'package:flutter/material.dart';
import 'pages/login_page.dart';

void main() {
  runApp(const FarmingApp());
}

class FarmingApp extends StatelessWidget {
  const FarmingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Farm Connect',
      theme: ThemeData(
        primaryColor: const Color(0xFF388E3C),
        primarySwatch: Colors.green,
        fontFamily: 'Inter',
        scaffoldBackgroundColor: const Color(0xFFF0F4F8),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.transparent,
          titleTextStyle: TextStyle(
            color: Color(0xFF212121),
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(color: Color(0xFF212121)),
        ),
      ),
      home: const LoginPage(), // 🚀 entry point
      debugShowCheckedModeBanner: false,
    );
  }
}