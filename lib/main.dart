import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rush/features/auth/screens/splash_screen.dart';
import 'package:rush/utils/navigation.dart';


void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
    navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Rush',
      home: const SplashScreen(),
    );
  }
}
