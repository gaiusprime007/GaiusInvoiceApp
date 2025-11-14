import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math';

import 'package:invoice_app/model/invoice_items.dart';

class InvoiceController extends GetxController {
  //dandom invoice numbers
  String generateRandomInvoiceNumbers() {
    final random = Random();
    int number = 1000 + random.nextInt(900);
    return 'INV-$number';
  }

  final senderController = TextEditingController();
  final recepientController = TextEditingController();

  //Selected Date Controller
  final selectedDate = Rx<DateTime?>(null);

  Future<void> selectDateIssued(context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Colors.black,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      selectedDate.value = picked;
    }
  }


  final RxList<SectionModel> sections = <SectionModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    addSection('Backend');
    addSection('Frontend');
    addSection('Fullstack');
    addSection('Add-ons');
  }

  void addSection(String title) {
    final s = SectionModel(title: title);
    final invoiceItem = InvoiceItem();
    s.items.add(invoiceItem);
    sections.add(s);
  }

  // <________ITEM MANAGEMENT_______>

  //add row
  void addRow(SectionModel section) {
    final invItem = InvoiceItem();
    section.items.add(invItem);
    _updateSectionSubtotal(section);
  }

  //remove row
  void removeRow(SectionModel section, int index) {
    section.items[index].dispose();
    section.items.removeAt(index);
    _updateSectionSubtotal(section);
  }

  // Section Ssubtotal

  void _updateSectionSubtotal(SectionModel section) {
    double total = 0.0;
    for (var item in section.items) {
      total += item.rowTotal.value;
    }
    section.subTotal.value = total;

    _calculateSubtotalGross();
    _updateGrandTotal();
  }

  //update row and subtotal
  void updateRowAndSubtotal(SectionModel section) {
    _updateSectionSubtotal(section);
  }

  // -----------------------
  // DISCOUNT / TAX / GRAND TOTAL
  // -----------------------
  final discountPercentageController = TextEditingController();
  final discount = 0.0.obs;
  final tax = 0.0.obs;
  final subTotalGross = 0.0.obs;
  final grandTotal = 0.0.obs;

  void _calculateSubtotalGross() {
    double total = sections.fold(0.0, (sum, s) => sum + s.subTotal.value);
    subTotalGross.value = total;
  }

  void _updateGrandTotal() {
    double total = sections.fold(0.0, (sum, s) => sum + s.subTotal.value);
    total = total - discount.value + tax.value;
    grandTotal.value = total;
  }

  void calculateDiscount() {
    final percentage = double.tryParse(discountPercentageController.text) ?? 0;
    discount.value = (subTotalGross.value * percentage) / 100;

    _updateGrandTotal();
  }

 void resetInvoice() {

  
  // Clear From/To fields
  senderController.clear();
  recepientController.clear();

  // Clear Discount / Tax
  discountPercentageController.clear();
  discount.value = 0.0;
  // taxPercentageController.clear();
  tax.value = 0.0;

  // Clear sections
  for (var section in sections) {
    for (var item in section.items) {
      item.dispose();
    }
    section.items.clear();
    section.subTotal.value = 0.0;
  }
  sections.clear();

  // Reset totals
  subTotalGross.value = 0.0;
  grandTotal.value = 0.0;

  // Add default sections again
  addSection('Backend');
  addSection('Frontend');
  addSection('Fullstack');
  addSection('Add-ons');
}


  @override
  void onClose() {
    for (var s in sections) {
      s.dispose();
    }

    senderController.dispose();
    recepientController.dispose();

    discountPercentageController.dispose();
    super.onClose();
  }
}
