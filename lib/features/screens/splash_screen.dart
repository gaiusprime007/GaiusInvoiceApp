import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invoice_app/features/screens/invoice_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () => Get.offAll(transition: Transition.rightToLeft, () => InvoicePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.asset(width: 200, height: 200, 'assets/Gaius_logo.jpg'),
      ),
    );
  }
}
