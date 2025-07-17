import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:society_gate/constents/date_format.dart';

Future<void> generateInvoicePdf({
  // required String invoiceNumber,
  required String customerName,
  required String contact,
  required String email,
  required String societyName,
  required String block,
  required String flatNo,
  required String paymentDate,
  required String paymentMode,
  required String paidAmount,
  required String fineType,
}) async {
  final pdf = pw.Document();

  // final logoImage = pw.MemoryImage(
  //   (await rootBundle.load('assets/logo.png')).buffer.asUint8List(),
  // );

  EasyLoading.dismiss();

  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (context) {
        return pw.Container(
          padding: const pw.EdgeInsets.all(24),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Header
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  // pw.Image(logoImage, width: 80),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Text('Payment Invoice',
                          style: pw.TextStyle(
                              fontSize: 22, fontWeight: pw.FontWeight.bold)),
                      // pw.Text('Invoice No: $invoiceNumber'),
                      pw.Text('Date: ${formatDate(paymentDate)}'),
                    ],
                  ),
                ],
              ),
              pw.SizedBox(height: 20),

              // Customer Details
              pw.Text('Customer Details',
                  style: pw.TextStyle(
                      fontSize: 16, fontWeight: pw.FontWeight.bold)),
              pw.Divider(),
              pw.Text('Name: $customerName'),
              pw.Text('Contact: $contact'),
              pw.Text('Email: $email'),
              pw.Text('Society: $societyName'),
              pw.Text('Block: $block, Flat No: $flatNo'),
              pw.SizedBox(height: 20),

              // Payment Details
              pw.Text('Payment Details',
                  style: pw.TextStyle(
                      fontSize: 16, fontWeight: pw.FontWeight.bold)),
              pw.Divider(),
              pw.Text('Payment Mode: $paymentMode'),
              pw.Text('Fine Type: $fineType'),
              pw.Text('Paid Amount: $paidAmount',
                  style: const pw.TextStyle(fontSize: 14)),
              pw.SizedBox(height: 20),

              // Summary Table
              pw.Table.fromTextArray(
                cellAlignment: pw.Alignment.centerLeft,
                headerDecoration:
                    const pw.BoxDecoration(color: PdfColors.grey300),
                headers: ['Description', 'Amount'],
                data: [
                  [fineType, paidAmount],
                  ['Total Paid', paidAmount],
                ],
              ),

              pw.SizedBox(height: 30),
              pw.Text('Thank you for your payment!',
                  style: pw.TextStyle(fontStyle: pw.FontStyle.italic)),
              pw.SizedBox(height: 10),
              pw.Text('Support: support@societygate.com'),
            ],
          ),
        );
      },
    ),
  );

  // Preview & Print
  await Printing.layoutPdf(onLayout: (format) => pdf.save());
}
