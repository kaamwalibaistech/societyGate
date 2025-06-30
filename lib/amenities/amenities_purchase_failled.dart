import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:society_gate/models/amenities_ceate_order.dart';

class AmenitiesPurchaseFailedPage extends StatelessWidget {
  final String? paymentId;
  final String? orderId;
  final CreateOrderForAmenities? orderDetails;

  const AmenitiesPurchaseFailedPage({
    super.key,
    required this.paymentId,
    required this.orderId,
    required this.orderDetails,
  });

  @override
  Widget build(BuildContext context) {
    EasyLoading.dismiss();
    double total = (orderDetails?.amount ?? 0) / 100;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Booking Failed"),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 70, color: Colors.red),
              const SizedBox(height: 16),
              const Text(
                "Amenities Purchase Failed",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              const Text(
                "Your payment was successful, but we were unable to book your amenities.",
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              _infoTile("Payment ID", paymentId ?? "N/A"),
              _infoTile("Order ID", orderId ?? "N/A"),
              _infoTile("Ammount", total.toString()),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                icon: const Icon(Icons.support_agent),
                label: const Text("Contact Support"),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    minimumSize: const Size(double.infinity, 48)),
                onPressed: () {},
              ),
              const SizedBox(height: 16),
              OutlinedButton.icon(
                icon: const Icon(Icons.home),
                label: const Text("Back to Home"),
                style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 48)),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoTile(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(color: Colors.black87)),
        const Divider(),
      ],
    );
  }
}
