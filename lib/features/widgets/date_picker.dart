import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invoice_app/features/controllers/invoice_controller.dart';

class InvoiceDatePicker extends StatelessWidget {
  final String label;

  InvoiceDatePicker({super.key, required this.label});

  final controller = Get.put<InvoiceController>(InvoiceController());
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.selectDateIssued(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.white54,
              fontSize: 13,
              height: 1.5,
            ),
            textAlign: TextAlign.right,
          ),
          const SizedBox(height: 4),
          Obx(() {
            return Text(
              controller.selectedDate.value != null
                  ? "${controller.selectedDate.value?.day}/${controller.selectedDate.value?.month}/${controller.selectedDate.value?.year}"
                  : "Select date",
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
            );
          }),
        ],
      ),
    );
  }
}
