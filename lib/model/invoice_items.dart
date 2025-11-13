import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InvoiceItem {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController hoursController = TextEditingController();
  final TextEditingController rateController = TextEditingController();

  final RxDouble rowTotal = 0.0.obs;
  // final Function() onTotalChanged;

  InvoiceItem() {
    //automtically update subtotal when user types
    hoursController.addListener(_updateRowTotal);
    rateController.addListener(_updateRowTotal);
  }

  void _updateRowTotal() {
    final hours = double.tryParse(hoursController.text) ?? 0;
    final rate = double.tryParse(rateController.text) ?? 0;
    rowTotal.value = hours * rate;
  }

  void dispose() {
    nameController.dispose();
    hoursController.dispose();
    rateController.dispose();
  }
}

class SectionModel {
  final String title;
  final RxList<InvoiceItem> items = <InvoiceItem>[].obs;
  final RxDouble subTotal = 0.0.obs;

  SectionModel({required this.title}) {
    // addItem();
  }
 

  void dispose() {
    for (var item in items) {
      item.dispose();
    }
  }
}
