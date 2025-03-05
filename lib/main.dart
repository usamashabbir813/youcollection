import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youcollection/auth-ui/sign-in-screen.dart';
import 'package:youcollection/auth-ui/splash-screen.dart';

// ignore: unused_import
import 'user-panel/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: '',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SigninScreen(),
    );
  }
}
