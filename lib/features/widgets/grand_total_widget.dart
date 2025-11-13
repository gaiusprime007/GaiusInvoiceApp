import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invoice_app/features/controllers/invoice_controller.dart';

// ignore: must_be_immutable
class GrandTotalWidget extends StatelessWidget {
  String? label;
  RxDouble? amount;
  bool? isBold;
  bool? big;

  GrandTotalWidget({
    super.key,
    required this.label,
    required this.amount,
    this.isBold = false,
    this.big = false,
  });

  final controller = Get.put(InvoiceController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label!,
            style: TextStyle(
              color: Colors.white70,
              fontWeight: isBold! ? FontWeight.bold : FontWeight.normal,
              fontSize: big! ? 16 : 14,
            ),
          ),
          Obx(() {
            return Text(
              '₵${amount!.value.toStringAsFixed(2)}',
              style: TextStyle(
                color: Colors.white,
                fontWeight: isBold! ? FontWeight.bold : FontWeight.normal,
                fontSize: big! ? 18 : 14,
              ),
            );
          }),
        ],
      ),
    );
  }
}
