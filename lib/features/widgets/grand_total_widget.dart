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
    final screenWidth = MediaQuery.of(context).size.width;

    // Dynamic font sizes
    final double labelFontSize = big!
        ? (screenWidth < 350
              ? 16
              : screenWidth < 600
              ? 16
              : 18)
        : (screenWidth < 350
              ? 12
              : screenWidth < 600
              ? 14
              : 16);

    final double amountFontSize = big!
        ? (screenWidth < 350
              ? 18
              : screenWidth < 600
              ? 18
              : 20)
        : (screenWidth < 350
              ? 12
              : screenWidth < 600
              ? 14
              : 16);

    // Dynamic vertical padding
    final verticalPadding = screenWidth < 350
        ? 2.0
        : screenWidth < 600
        ? 4.0
        : 6.0;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: verticalPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label!,
            style: TextStyle(
              color: Colors.white70,
              fontWeight: isBold! ? FontWeight.bold : FontWeight.normal,
              fontSize: labelFontSize,
            ),
          ),
          Obx(() {
            return Text(
              '₵${amount!.value.toStringAsFixed(2)}',
              style: TextStyle(
                color: Colors.white,
                fontWeight: isBold! ? FontWeight.bold : FontWeight.normal,
                fontSize: amountFontSize,
              ),
            );
          }),
        ],
      ),
    );
  }
}
