import 'package:flutter/material.dart';

class InvoiceNumberWidget extends StatelessWidget {
  final String label;
  final String value;

  const InvoiceNumberWidget({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Adjust font sizes dynamically
    final labelFontSize = screenWidth < 350
        ? 12.0
        : screenWidth < 600
        ? 13.0
        : 14.0;

    final valueFontSize = screenWidth < 350
        ? 14.0
        : screenWidth < 600
        ? 15.0
        : 16.0;

    final spacing = screenWidth < 350
        ? 2.0
        : screenWidth < 600
        ? 4.0
        : 6.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white54,
            fontSize: labelFontSize,
            height: 1.5,
          ),
        ),
        SizedBox(height: spacing),
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: valueFontSize,
          ),
        ),
      ],
    );
  }
}
