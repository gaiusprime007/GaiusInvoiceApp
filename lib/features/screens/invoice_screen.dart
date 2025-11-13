import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invoice_app/features/controllers/invoice_controller.dart';
import 'package:invoice_app/features/widgets/collapsable_section.dart';
import 'package:invoice_app/features/widgets/custom_textfield.dart';
import 'package:invoice_app/features/widgets/date_picker.dart';
import 'package:invoice_app/features/widgets/grand_total_widget.dart';
import 'package:invoice_app/features/widgets/invoice_number.dart';
import 'package:invoice_app/features/widgets/payment_card.dart';

class InvoicePage extends StatelessWidget {
  InvoicePage({super.key});
  final controller = Get.put<InvoiceController>(InvoiceController());

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 2,

        backgroundColor: Colors.black,
        elevation: 0.2,
        title: const Text('Invoice'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Date and Invoice Number
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox.square(
                  dimension: 80,
                  child: Image.asset('assets/Gaius_logo.jpg'),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: InvoiceNumberWidget(
                    label: 'Invoice #',
                    value: controller.generateRandomInvoiceNumbers(),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: InvoiceDatePicker(label: 'Date Issued'),
                ),
              ],
            ),

            const Divider(color: Colors.white24, height: 32),
            const SizedBox(height: 16),

            // FROM / TO SECTION
            Text(
              "Address",
              style: textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            CustomTextFormField(label: 'From', isWidthAdjustable: false),
            SizedBox(height: 10),
            CustomTextFormField(label: 'To', isWidthAdjustable: false),

            const Divider(color: Colors.white24, height: 32),

            // COLLAPSIBLE SECTIONS
            Text(
              "Items",
              style: textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 8),
            Obx(() {
              return Column(
                children: controller.sections.map((section) {
                  return Column(
                    children: [
                      CollapsableSection(
                        title: section.title,
                        section: section,
                      ),
                      const SizedBox(height: 8),
                    ],
                  );
                }).toList(),
              );
            }),
            const Divider(color: Colors.white24, height: 32),
            CustomTextFormField(
              label: 'Discount',
              controller: controller.discountPercentageController,
              isWidthAdjustable: false,
              onChanged: (value) => controller.calculateDiscount(),
            ),

            const Divider(color: Colors.white24, height: 32),

            // TOTALS
            GrandTotalWidget(
              label: 'Subtotal',
              amount: controller.subTotalGross,
            ),
            GrandTotalWidget(label: 'Discount', amount: controller.discount),
            // GrandTotalWidget(label: 'Tax', amount: controller.tax),
            const Divider(color: Colors.white24),
            GrandTotalWidget(
              label: 'Total Amount Due',
              amount: controller.grandTotal,
              isBold: true,
              big: true,
            ),

            const SizedBox(height: 32),
            Text(
              "Payment Plan",
              style: textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),
            const PaymentCardWidget(
              title: "50% Upfront",
              subtitle: "Due upon invoice receipt.",
            ),
            const PaymentCardWidget(
              title: "25% on Completion",
              subtitle: "Due upon completion of agreed milestone.",
            ),
            const PaymentCardWidget(
              title: "25% on Distribution",
              subtitle: "Due upon final project delivery.",
            ),

            const SizedBox(height: 32),
            const Divider(color: Colors.white24),
            const SizedBox(height: 16),

            // FOOTER
            Center(
              child: Column(
                children: [
                  Text(
                    "Gaius Tech.",
                    style: textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const Text(
                    "+233 (55) 051 7071",
                    style: TextStyle(color: Colors.white60, fontSize: 12),
                  ),
                  const Text(
                    "gaiusdeveloper@gaiustechnologies.com",
                    style: TextStyle(color: Colors.white60, fontSize: 12),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.download, color: Colors.white),
                    label: const Text(
                      "Download PDF",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.white24),
                    ),
                    onPressed: () {},
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.add, color: Colors.white),
                    label: const Text(
                      "Generate New",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.white24),
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
