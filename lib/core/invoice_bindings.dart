import 'package:get/get.dart';
import 'package:invoice_app/features/controllers/invoice_controller.dart';

class InvoiceBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Get.find<InvoiceController>());
  }
}
