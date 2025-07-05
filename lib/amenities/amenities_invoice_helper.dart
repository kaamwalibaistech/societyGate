import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:society_gate/models/amenities_buy_done.dart';
import 'package:society_gate/models/amenities_ceate_order.dart';
import 'package:society_gate/models/login_model.dart';

Future<void> generateAndDownloadInvoice(
  BuildContext context,
  LoginModel? loginModel,
  BuyAmenitiesDone? buyAmenitiesDone,
  CreateOrderForAmenities? orderDetails,
  String? paymentId,
) async {
  EasyLoading.dismiss();
  final pdf = pw.Document();
  final bookings = buyAmenitiesDone?.data ?? [];
  String total = ((orderDetails?.amount ?? 0) / 100).toStringAsFixed(2);

  pdf.addPage(
    pw.MultiPage(
      build: (pw.Context context) => [
        /// HEADER
        pw.Header(
          level: 0,
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text('Society Gate',
                  style: pw.TextStyle(
                      fontSize: 22, fontWeight: pw.FontWeight.bold)),
              pw.Text('Invoice',
                  style: const pw.TextStyle(
                      fontSize: 20, color: PdfColors.grey700)),
            ],
          ),
        ),

        pw.SizedBox(height: 10),

        /// PERSONAL + SOCIETY DETAILS SIDE-BY-SIDE
        pw.Text("Customer Details",
            style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
        pw.Divider(),

        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Expanded(
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  _invoiceItem("Name", loginModel?.user?.uname ?? ''),
                  _invoiceItem("Contact", loginModel?.user?.uphone ?? ''),
                  _invoiceItem("Email", loginModel?.user?.uemail ?? ''),
                ],
              ),
            ),
            pw.SizedBox(width: 30),
            pw.Expanded(
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  _invoiceItem(
                      "Society Name", loginModel?.user?.societyName ?? ''),
                  _invoiceItem("Block", loginModel?.user?.block ?? ''),
                  _invoiceItem("Flat No", loginModel?.user?.flatNumber ?? ''),
                ],
              ),
            ),
          ],
        ),

        pw.SizedBox(height: 20),

        /// PAYMENT DETAILS
        pw.Text("Payment Details",
            style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
        pw.Divider(),
        _invoiceItem(
          "Payment ID",
          paymentId,
        ),
        _invoiceItem("Order ID", orderDetails?.orderId),
        _invoiceItem("Receipt ID", orderDetails?.fullResponse?['receipt']),

        pw.SizedBox(height: 20),

        /// AMENITIES TABLE
        pw.Text("Booked Amenities",
            style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
        pw.Divider(),

        pw.Table.fromTextArray(
          border: null,
          headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
          cellAlignment: pw.Alignment.center,
          headerDecoration: const pw.BoxDecoration(color: PdfColors.grey200),
          columnWidths: {
            0: const pw.FlexColumnWidth(2),
            1: const pw.FlexColumnWidth(3),
            2: const pw.FlexColumnWidth(2),
            3: const pw.FlexColumnWidth(3),
            4: const pw.FlexColumnWidth(3),
            5: const pw.FlexColumnWidth(2),
          },
          headers: ['Sr.No.', 'Amenity', 'Duration', 'Start', 'End', 'Amount'],
          data: bookings.map((e) {
            return [
              bookings.indexOf(e) + 1,
              e.amenityName ?? '',
              e.duration ?? '',
              e.startTime ?? '',
              e.endTime ?? '',
              (e.amount ?? ''),
            ];
          }).toList(),
        ),

        pw.SizedBox(height: 10),
        pw.Align(
            alignment: pw.Alignment.bottomRight,
            child: pw.Padding(
              padding: const pw.EdgeInsets.only(right: 20),
              child: pw.Text("Total: $total",
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold, fontSize: 14)),
            )),
        pw.SizedBox(height: 30),
        pw.Divider(),

        pw.Text("Thank you for booking with Society Gate!",
            style: pw.TextStyle(fontStyle: pw.FontStyle.italic)),
      ],
    ),
  );

  await Printing.layoutPdf(
    onLayout: (PdfPageFormat format) async => pdf.save(),
    name: 'Amenities_Invoice_${paymentId ?? "receipt"}.pdf',
  );
}

pw.Widget _invoiceItem(String title, String? value) {
  return pw.Padding(
    padding: const pw.EdgeInsets.only(bottom: 4),
    child: pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text("$title: ",
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        pw.Expanded(child: pw.Text(value ?? 'N/A')),
      ],
    ),
  );
}

/*
String _formatDate(String isoDate) {
  try {
    final date = DateTime.parse(isoDate);
    return DateFormat('dd MMM yyyy').format(date);
  } catch (e) {
    return isoDate;
  }
}
*/
