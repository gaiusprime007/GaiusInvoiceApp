import 'package:flutter/material.dart';

class InvoiceNumberWidget extends StatelessWidget {
  final String label;
  final String value;
  const InvoiceNumberWidget({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(
          color: Colors.white54,
          fontSize: 13,
          height: 1.5,
        ),
      ),
      Text(
        value,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    ],
  );
  }
}

