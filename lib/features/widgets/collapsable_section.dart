import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invoice_app/features/controllers/invoice_controller.dart';
import 'package:invoice_app/model/invoice_items.dart';

class CollapsableSection extends StatelessWidget {
  final String title;
  final SectionModel section;
  final controller = Get.put(InvoiceController());

  CollapsableSection({super.key, required this.section, required this.title}) {
    if (section.items.isEmpty) controller.addRow(section);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Card(
      color: Colors.white10,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.white24),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ExpansionTile(
        shape: const Border(bottom: BorderSide(color: Colors.transparent)),
        collapsedIconColor: Colors.white,
        iconColor: Colors.white,
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Obx(() {
              return Column(
                children: [
                  // Table headers
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        Expanded(
                          flex: width > 400 ? 3 : 4,
                          child: const Text(
                            "Service",
                            style: TextStyle(color: Colors.white54),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: const Text(
                            "Hours",
                            textAlign: TextAlign.right,
                            style: TextStyle(color: Colors.white54),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: const Text(
                            "Rate",
                            textAlign: TextAlign.right,
                            style: TextStyle(color: Colors.white54),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: const Text(
                            "Total",
                            textAlign: TextAlign.right,
                            style: TextStyle(color: Colors.white54),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Divider(color: Colors.white30),

                  // Editable rows
                  ...section.items.asMap().entries.map((entry) {
                    final index = entry.key;
                    final item = entry.value;

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Dismissible(
                        key: ValueKey(index),
                        onDismissed: (_) =>
                            controller.removeRow(section, index),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          color: Colors.redAccent,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        child: Row(
                          children: [
                            // Service Name
                            Expanded(
                              flex: width > 400 ? 3 : 4,
                              child: TextField(
                                controller: item.nameController,
                                style: const TextStyle(color: Colors.white),
                                decoration: const InputDecoration(
                                  hintText: "Features",
                                  hintStyle: TextStyle(color: Colors.white38),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            // Hours
                            Expanded(
                              flex: 1,
                              child: TextField(
                                cursorColor: Colors.white24,
                                cursorHeight: 14,
                                controller: item.hoursController,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.right,
                                style: const TextStyle(color: Colors.white),
                                decoration: const InputDecoration(
                                  hintText: "0",
                                  hintStyle: TextStyle(color: Colors.white38),
                                  border: InputBorder.none,
                                ),
                                onChanged: (_) =>
                                    controller.updateRowAndSubtotal(section),
                              ),
                            ),
                            // Rate
                            Expanded(
                              flex: 1,
                              child: TextField(
                                cursorColor: Colors.white24,
                                cursorHeight: 14,
                                controller: item.rateController,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.right,
                                style: const TextStyle(color: Colors.white),
                                decoration: const InputDecoration(
                                  hintText: "₵0.00",
                                  hintStyle: TextStyle(color: Colors.white38),
                                  border: InputBorder.none,
                                ),
                                onChanged: (_) =>
                                    controller.updateRowAndSubtotal(section),
                              ),
                            ),
                            // Total
                            Expanded(
                              flex: 1,
                              child: Obx(
                                () => Text(
                                  "₵${item.rowTotal.value.toStringAsFixed(2)}",
                                  textAlign: TextAlign.right,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ],
              );
            }),
          ),

          // Section subtotal
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text(
                  "Subtotal: ",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Obx(
                  () => Text(
                    "₵${section.subTotal.value.toStringAsFixed(2)}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Add Row button
          Padding(
            padding: const EdgeInsets.only(bottom: 16, right: 16),
            child: Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: () => controller.addRow(section),
                icon: const Icon(Icons.add, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
