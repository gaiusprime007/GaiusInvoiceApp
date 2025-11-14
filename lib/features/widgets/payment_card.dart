import 'package:flutter/material.dart';

class PaymentCardWidget extends StatelessWidget {
  final String title;
  final String subtitle;

  const PaymentCardWidget({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Responsive font sizes
    final titleFontSize = screenWidth < 350
        ? 14.0
        : screenWidth < 600
        ? 15.0
        : 16.0;

    final subtitleFontSize = screenWidth < 350
        ? 12.0
        : screenWidth < 600
        ? 13.0
        : 14.0;

    // Responsive padding
    final containerPadding = screenWidth < 350
        ? 12.0
        : screenWidth < 600
        ? 16.0
        : 20.0;

    final spacing = screenWidth < 350
        ? 3.0
        : screenWidth < 600
        ? 4.0
        : 6.0;

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: spacing * 2),
      padding: EdgeInsets.all(containerPadding),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.white,
              fontSize: titleFontSize,
            ),
          ),
          SizedBox(height: spacing),
          Text(
            subtitle,
            style: TextStyle(color: Colors.white70, fontSize: subtitleFontSize),
          ),
        ],
      ),
    );
  }
}
