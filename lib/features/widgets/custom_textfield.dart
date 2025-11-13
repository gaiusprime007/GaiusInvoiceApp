import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final DateTime? date;
  final bool isWidthAdjustable;
  final double? fontSize;
  final double? height;
  final ValueChanged<String>? onChanged;
  // final double? width;
  const CustomTextFormField({
    super.key,
    this.controller,
    required this.label,
    this.date,
    this.isWidthAdjustable = true,
    this.fontSize,
    this.height,
    this.onChanged
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isWidthAdjustable ? 120 : double.infinity,
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
          decoration: InputDecoration(
            label: Text(label),
            labelStyle: TextStyle(color: Colors.white, fontSize: fontSize),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.white24),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.white24),
            ),
          ),
        ),
      ),
    );
  }
}
