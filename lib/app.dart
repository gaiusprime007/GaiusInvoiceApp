import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invoice_app/features/screens/splash_screen.dart';

class InvoiceApp extends StatelessWidget {
  const InvoiceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
    
      title: 'Invoice',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
          bodyLarge: TextStyle(color: Colors.white),
          titleMedium: TextStyle(color: Colors.white),
        ),
      ),

      home: SplashScreen(),
    );
  }
}
