import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invoice_app/features/controllers/invoice_controller.dart';

class InvoiceDatePicker extends StatelessWidget {
  final String label;

  InvoiceDatePicker({super.key, required this.label});

  final controller = Get.put<InvoiceController>(InvoiceController());

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Adjust font sizes dynamically
    final labelFontSize = screenWidth < 350
        ? 12.0
        : screenWidth < 600
        ? 13.0
        : 14.0;
    final dateFontSize = screenWidth < 350
        ? 14.0
        : screenWidth < 600
        ? 15.0
        : 16.0;

    final spacing = screenWidth < 350
        ? 2.0
        : screenWidth < 600
        ? 4.0
        : 6.0;

    return GestureDetector(
      onTap: () => controller.selectDateIssued(context),
      child: Column(
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
          Obx(() {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white24),
              ),
              child: Text(
                controller.selectedDate.value != null
                    ? "${controller.selectedDate.value?.day.toString().padLeft(2, '0')}/"
                          "${controller.selectedDate.value?.month.toString().padLeft(2, '0')}/"
                          "${controller.selectedDate.value?.year}"
                    : "Select date",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: dateFontSize,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
