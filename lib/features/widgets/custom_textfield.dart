import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final DateTime? date;
  final bool isWidthAdjustable;
  final double? fontSize;
  final double? height;
  final ValueChanged<String>? onChanged;

  const CustomTextFormField({
    super.key,
    this.controller,
    required this.label,
    this.date,
    this.isWidthAdjustable = true,
    this.fontSize,
    this.height,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Calculate dynamic width
    double fieldWidth;
    if (!isWidthAdjustable) {
      fieldWidth = double.infinity;
    } else if (screenWidth < 350) {
      fieldWidth = screenWidth * 0.5; // small screen
    } else if (screenWidth < 600) {
      fieldWidth = screenWidth * 0.35; // medium
    } else {
      fieldWidth = 200; // large screens
    }

    // Dynamic height (optional)
    final fieldHeight = height ?? 50.0;

    return SizedBox(
      width: fieldWidth,
      height: fieldHeight,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white24),
        ),
        child: TextFormField(
          onChanged: onChanged,
          cursorColor: Colors.white24,
          controller: controller,
          style: TextStyle(fontSize: fontSize ?? 14, color: Colors.white),
          decoration: InputDecoration(
            label: Text(
              label,
              style: TextStyle(color: Colors.white70, fontSize: fontSize ?? 14),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 14,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.white24),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.white24),
            ),
          ),
        ),
      ),
    );
  }
}
