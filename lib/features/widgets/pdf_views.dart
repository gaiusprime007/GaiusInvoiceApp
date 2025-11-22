import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:invoice_app/features/controllers/invoice_controller.dart';
import 'package:flutter/services.dart';
import 'package:printing/printing.dart';

class InvoicePdf {
  static Future<void> generate(InvoiceController controller) async {
    final pdf = pw.Document();

    // Load logo from assets
    final logoBytes = await rootBundle.load('assets/Gaius_logo.jpg');
    final logoImage = pw.MemoryImage(logoBytes.buffer.asUint8List());

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return [
            // Logo & Invoice Info
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Image(logoImage, width: 80, height: 80),
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'Invoice #${controller.generateRandomInvoiceNumbers()}',
                      style: pw.TextStyle(fontSize: 14),
                    ),
                    pw.SizedBox(height: 4),
                    pw.Text(
                      'Date: ${controller.selectedDate.value != null ? controller.selectedDate.value!.toIso8601String().split('T')[0] : DateTime.now().toIso8601String().split('T')[0]}',
                      style: pw.TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
            pw.SizedBox(height: 20),

            // From / To Addresses
            pw.Text(
              'Address',
              style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 8),
            pw.Text('From: ${controller.senderController.text}'),
            pw.Text('To: ${controller.recepientController.text}'),
            pw.SizedBox(height: 20),

            // Sections fully expanded
            ...controller.sections.map((section) {
              return pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    section.title,
                    style: pw.TextStyle(
                      fontSize: 16,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.SizedBox(height: 6),
                  // ignore: deprecated_member_use
                  pw.Table.fromTextArray(
                    headers: ['Feature', 'Rate'],
                    data: section.items.map((item) {
                      return [
                        item.nameController.text,
                        // item.hoursController.text,
                        // item.rateController.text,
                        item.rowTotal.value.toStringAsFixed(2),
                      ];
                    }).toList(),
                    headerStyle: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.white,
                    ),
                    headerDecoration: pw.BoxDecoration(
                      color: PdfColors.grey800,
                    ),
                    cellAlignment: pw.Alignment.centerLeft,
                    cellStyle: pw.TextStyle(color: PdfColors.white),
                    border: pw.TableBorder.all(color: PdfColors.white),
                  ),
                  pw.SizedBox(height: 4),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.end,
                    children: [
                      pw.Text(
                        'Subtotal: ₵${section.subTotal.value.toStringAsFixed(2)}',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      ),
                    ],
                  ),
                  pw.SizedBox(height: 12),
                ],
              );
            }),

            // Totals
            pw.Divider(),
            pw.SizedBox(height: 8),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text('Subtotal'),
                pw.Text(
                  '₵${controller.subTotalGross.value.toStringAsFixed(2)}',
                ),
              ],
            ),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text('Discount'),
                pw.Text('₵${controller.discount.value.toStringAsFixed(2)}'),
              ],
            ),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text('Tax'),
                pw.Text('₵${controller.tax.value.toStringAsFixed(2)}'),
              ],
            ),
            pw.Divider(),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text(
                  'Total Amount Due',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
                pw.Text(
                  '₵${controller.grandTotal.value.toStringAsFixed(2)}',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
              ],
            ),

            pw.SizedBox(height: 20),

            // Payment Plan
            pw.Text(
              'Payment Plan',
              style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 8),
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text('• 50% Upfront - Due upon invoice receipt.'),
                pw.Text('• 25% on Completion - Due upon milestone completion.'),
                pw.Text(
                  '• 25% on Distribution - Due upon final project delivery.',
                ),
              ],
            ),

            pw.SizedBox(height: 20),

            // Footer / Contact Info
            pw.Divider(),
            pw.SizedBox(height: 8),
            pw.Center(
              child: pw.Column(
                children: [
                  pw.Text(
                    'Gaius Tech.',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  ),
                  pw.Text(
                    '+233 (55) 051 7071',
                    style: pw.TextStyle(color: PdfColors.grey),
                  ),
                  pw.Text(
                    'gaiusdeveloper@gaiustechnologies.com',
                    style: pw.TextStyle(color: PdfColors.grey),
                  ),
                ],
              ),
            ),
          ];
        },
      ),
    );

    // Open PDF preview or print
    await Printing.layoutPdf(onLayout: (format) => pdf.save());
  }
}
