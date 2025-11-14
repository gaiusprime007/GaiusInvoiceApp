// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:invoice_app/features/controllers/invoice_controller.dart';
// import 'package:invoice_app/features/widgets/collapsable_section.dart';
// import 'package:invoice_app/features/widgets/custom_button.dart';
// import 'package:invoice_app/features/widgets/custom_textfield.dart';
// import 'package:invoice_app/features/widgets/date_picker.dart';
// import 'package:invoice_app/features/widgets/grand_total_widget.dart';
// import 'package:invoice_app/features/widgets/invoice_number.dart';
// import 'package:invoice_app/features/widgets/payment_card.dart';
// import 'package:invoice_app/features/widgets/pdf_views.dart';

// class InvoicePage extends StatelessWidget {
//   InvoicePage({super.key});
//   final controller = Get.put<InvoiceController>(InvoiceController());

//   @override
//   Widget build(BuildContext context) {
//     final textTheme = Theme.of(context).textTheme;
//     return Scaffold(
//       appBar: AppBar(
//         scrolledUnderElevation: 2,

//         backgroundColor: Colors.black,
//         elevation: 0.2,
//         title: const Text('Invoice'),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),

//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             //Date and Invoice Number
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 SizedBox.square(
//                   dimension: 80,
//                   child: Image.asset('assets/Gaius_logo.jpg'),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 8.0),
//                   child: InvoiceNumberWidget(
//                     label: 'Invoice #',
//                     value: controller.generateRandomInvoiceNumbers(),
//                   ),
//                 ),

//                 Padding(
//                   padding: const EdgeInsets.only(right: 10),
//                   child: InvoiceDatePicker(label: 'Date Issued'),
//                 ),
//               ],
//             ),

//             const Divider(color: Colors.white24, height: 32),
//             const SizedBox(height: 16),

//             // FROM / TO SECTION
//             Text(
//               "Address",
//               style: textTheme.titleLarge!.copyWith(
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             // CustomTextFormField(
//             //   label: 'From',
//             //   isWidthAdjustable: false,
//             //   controller: controller.senderController,
//             // ),
//             SizedBox(height: 10),
//             CustomTextFormField(
//               label: ' Bill To',
//               isWidthAdjustable: false,
//               controller: controller.recepientController,
//             ),

//             const Divider(color: Colors.white24, height: 32),

//             // COLLAPSIBLE SECTIONS
//             Text(
//               "Items",
//               style: textTheme.titleLarge!.copyWith(
//                 fontWeight: FontWeight.bold,
//               ),
//             ),

//             SizedBox(height: 8),
//             Obx(() {
//               return Column(
//                 children: controller.sections.map((section) {
//                   return Column(
//                     children: [
//                       CollapsableSection(
//                         title: section.title,
//                         section: section,
//                       ),
//                       const SizedBox(height: 8),
//                     ],
//                   );
//                 }).toList(),
//               );
//             }),
//             const Divider(color: Colors.white24, height: 32),
//             CustomTextFormField(
//               label: 'Discount',
//               controller: controller.discountPercentageController,
//               isWidthAdjustable: false,
//               onChanged: (value) => controller.calculateDiscount(),
//             ),

//             const Divider(color: Colors.white24, height: 32),

//             // TOTALS
//             GrandTotalWidget(
//               label: 'Subtotal',
//               amount: controller.subTotalGross,
//             ),
//             GrandTotalWidget(label: 'Discount', amount: controller.discount),
//             // GrandTotalWidget(label: 'Tax', amount: controller.tax),
//             const Divider(color: Colors.white24),
//             GrandTotalWidget(
//               label: 'Total Amount Due',
//               amount: controller.grandTotal,
//               isBold: true,
//               big: true,
//             ),

//             const SizedBox(height: 32),
//             Text(
//               "Payment Plan",
//               style: textTheme.titleLarge!.copyWith(
//                 fontWeight: FontWeight.bold,
//               ),
//             ),

//             const SizedBox(height: 12),
//             const PaymentCardWidget(
//               title: "50% Upfront",
//               subtitle: "Due upon invoice receipt.",
//             ),
//             const PaymentCardWidget(
//               title: "25% on Completion",
//               subtitle: "Due upon completion of agreed milestone.",
//             ),
//             const PaymentCardWidget(
//               title: "25% on Distribution",
//               subtitle: "Due upon final project delivery.",
//             ),

//             const SizedBox(height: 32),
//             const Divider(color: Colors.white24),
//             const SizedBox(height: 16),

//             // FOOTER
//             Center(
//               child: Column(
//                 children: [
//                   Text(
//                     "Gaius Tech.",
//                     style: textTheme.bodyLarge!.copyWith(
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),

//                   const Text(
//                     "+233 (55) 051 7071",
//                     style: TextStyle(color: Colors.white60, fontSize: 12),
//                   ),
//                   const Text(
//                     "gaiusdeveloper@gaiustechnologies.com",
//                     style: TextStyle(color: Colors.white60, fontSize: 12),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 24),
//             Row(
//               children: [
//                 Expanded(
//                   child: CustomButton(
//                     label: 'Download Invoice',
//                     icon: Icons.download,
//                     onPressed: () => InvoicePdf.generate(controller),
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: CustomButton(
//                     label: 'Generate New',
//                     icon: Icons.add,
//                     onPressed: () {
//                       Get.defaultDialog(
//                         title: "Confirm",
//                         titleStyle: TextStyle(color: Colors.black87),
//                         middleText:
//                             "Are you sure you want to generate a new invoice? All data will be lost.",
//                         textConfirm: "Yes",

//                         textCancel: "No",
//                         confirmTextColor: Colors.white,
//                         middleTextStyle: TextStyle(color: Colors.black87),
//                         onConfirm: () {
//                           controller.resetInvoice();
//                           Get.back(); // Close dialog
//                         },
//                         cancelTextColor: Colors.black87,
//                         backgroundColor: Colors.white,
//                         buttonColor: Colors.black87,
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 50),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invoice_app/features/controllers/invoice_controller.dart';
import 'package:invoice_app/features/widgets/collapsable_section.dart';
import 'package:invoice_app/features/widgets/custom_button.dart';
import 'package:invoice_app/features/widgets/custom_textfield.dart';
import 'package:invoice_app/features/widgets/date_picker.dart';
import 'package:invoice_app/features/widgets/grand_total_widget.dart';
import 'package:invoice_app/features/widgets/invoice_number.dart';
import 'package:invoice_app/features/widgets/payment_card.dart';
import 'package:invoice_app/features/widgets/pdf_views.dart';

class InvoicePage extends StatelessWidget {
  InvoicePage({super.key});
  final controller = Get.put<InvoiceController>(InvoiceController());

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final screenWidth = MediaQuery.of(context).size.width;

    // Responsive spacing and sizing
    double horizontalPadding = screenWidth < 350
        ? 8
        : screenWidth < 600
        ? 16
        : 24;

    double logoSize = screenWidth < 350
        ? 60
        : screenWidth < 600
        ? 80
        : 100;

    double spacingSmall = screenWidth < 350
        ? 6
        : screenWidth < 600
        ? 10
        : 16;

    double spacingMedium = screenWidth < 350
        ? 12
        : screenWidth < 600
        ? 16
        : 24;

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 2,
        backgroundColor: Colors.black,
        elevation: 0.2,
        title: const Text('Invoice'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(horizontalPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Logo + Invoice Number + Date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox.square(
                  dimension: logoSize,
                  child: Image.asset('assets/Gaius_logo.jpg'),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: spacingSmall),
                    child: InvoiceNumberWidget(
                      label: 'Invoice #',
                      value: controller.generateRandomInvoiceNumbers(),
                    ),
                  ),
                ),
                InvoiceDatePicker(label: 'Date Issued'),
              ],
            ),
            Divider(color: Colors.white24, height: spacingMedium),
            SizedBox(height: spacingSmall),

            // Address Section
            Text(
              "Address",
              style: textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spacingSmall),
            CustomTextFormField(
              label: 'Bill To',
              isWidthAdjustable: false,
              controller: controller.recepientController,
            ),
            SizedBox(height: spacingMedium),

            Divider(color: Colors.white24, height: spacingMedium),
            SizedBox(height: spacingSmall),

            // Collapsible Items
            Text(
              "Items",
              style: textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spacingSmall),
            Obx(() {
              return Column(
                children: controller.sections.map((section) {
                  return Column(
                    children: [
                      CollapsableSection(
                        title: section.title,
                        section: section,
                      ),
                      SizedBox(height: spacingSmall),
                    ],
                  );
                }).toList(),
              );
            }),
            Divider(color: Colors.white24, height: spacingMedium),
            SizedBox(height: spacingSmall),

            // Discount
            CustomTextFormField(
              label: 'Discount',
              controller: controller.discountPercentageController,
              isWidthAdjustable: false,
              onChanged: (_) => controller.calculateDiscount(),
            ),
            Divider(color: Colors.white24, height: spacingMedium),
            SizedBox(height: spacingSmall),

            // Totals
            GrandTotalWidget(
              label: 'Subtotal',
              amount: controller.subTotalGross,
            ),
            GrandTotalWidget(label: 'Discount', amount: controller.discount),
            Divider(color: Colors.white24),
            GrandTotalWidget(
              label: 'Total Amount Due',
              amount: controller.grandTotal,
              isBold: true,
              big: true,
            ),
            SizedBox(height: spacingMedium),

            Divider(color: Colors.white24, height: spacingMedium),
            SizedBox(height: spacingSmall),

            // Payment Plan
            Text(
              "Payment Plan",
              style: textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spacingMedium),
            const PaymentCardWidget(
              title: "50% Upfront",
              subtitle: "Due upon invoice receipt.",
            ),
            SizedBox(height: spacingSmall),
            const PaymentCardWidget(
              title: "25% on Completion",
              subtitle: "Due upon completion of agreed milestone.",
            ),
            SizedBox(height: spacingSmall),
            const PaymentCardWidget(
              title: "25% on Distribution",
              subtitle: "Due upon final project delivery.",
            ),
            SizedBox(height: spacingMedium),

            // Footer
            Divider(color: Colors.white24),
            SizedBox(height: spacingSmall),
            Center(
              child: Column(
                children: [
                  Text(
                    "Gaius Tech.",
                    style: textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "+233 (55) 051 7071",
                    style: TextStyle(
                      color: Colors.white60,
                      fontSize: screenWidth < 350
                          ? 10
                          : screenWidth < 600
                          ? 12
                          : 14,
                    ),
                  ),
                  Text(
                    "gaiusdeveloper@gaiustechnologies.com",
                    style: TextStyle(
                      color: Colors.white60,
                      fontSize: screenWidth < 350
                          ? 10
                          : screenWidth < 600
                          ? 12
                          : 14,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: spacingMedium),

            // Buttons
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    label: 'Download Invoice',
                    icon: Icons.download,
                    onPressed: () => InvoicePdf.generate(controller),
                  ),
                ),
                SizedBox(width: spacingSmall),
                Expanded(
                  child: CustomButton(
                    label: 'Generate New',
                    icon: Icons.add,
                    onPressed: () {
                      Get.defaultDialog(
                        title: "Confirm",
                        titleStyle: TextStyle(color: Colors.black87),
                        middleText:
                            "Are you sure you want to generate a new invoice? All data will be lost.",
                        textConfirm: "Yes",
                        textCancel: "No",
                        confirmTextColor: Colors.white,
                        middleTextStyle: TextStyle(color: Colors.black87),
                        onConfirm: () {
                          controller.resetInvoice();
                          Get.back();
                        },
                        cancelTextColor: Colors.black87,
                        backgroundColor: Colors.white,
                        buttonColor: Colors.black87,
                      );
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: spacingMedium),
          ],
        ),
      ),
    );
  }
}
