import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:society_gate/models/amenities_buy_done.dart';
import 'package:society_gate/models/amenities_ceate_order.dart';
import 'package:society_gate/amenities/user_amenities_page.dart';

class AmenitiesPaymentSuccess extends StatelessWidget {
  final BuyAmenitiesDone? buyAmenitiesDone;
  final CreateOrderForAmenities? orderDetails;
  final String? paymentId;
  final String? signature;

  const AmenitiesPaymentSuccess({
    super.key,
    required this.buyAmenitiesDone,
    required this.orderDetails,
    required this.paymentId,
    required this.signature,
  });

  @override
  Widget build(BuildContext context) {
    EasyLoading.dismiss();
    final order = orderDetails;
    final bookings = buyAmenitiesDone?.data ?? [];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment Successful"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🎉 Success Message
              const Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.green, size: 28),
                  SizedBox(width: 8),
                  Text(
                    "Payment Confirmed!",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // 💳 Payment Info
              Text("Payment Details",
                  style: Theme.of(context).textTheme.titleMedium),
              const Divider(),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text("Payment ID"),
                subtitle: Text(paymentId ?? 'N/A'),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text("Order ID"),
                subtitle: Text(order?.orderId ?? 'N/A'),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text("Amount Paid"),
                subtitle:
                    Text("₹ ${(order?.amount ?? 0) / 100} ${order?.currency}"),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text("Signature"),
                subtitle: Text(signature ?? 'N/A'),
              ),

              const SizedBox(height: 20),

              // 🏡 Amenity Details
              Text("Booked Amenities",
                  style: Theme.of(context).textTheme.titleMedium),
              const Divider(),
              ...bookings.map((amenity) => Card(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      leading: const Icon(Icons.room_preferences_rounded,
                          color: Colors.pink),
                      title: Text("Amenity ID: ${amenity.amenityId}"),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Amount: ₹ ${amenity.amount}"),
                          Text("Duration: ${amenity.duration}"),
                          Text(
                              "Start: ${_formatDate(amenity.startTime ?? '')}"),
                          Text("End: ${_formatDate(amenity.endTime ?? '')}"),
                        ],
                      ),
                    ),
                  )),

              const SizedBox(height: 80),
            ],
          ),
        ),
      ),

      // 🔘 Bottom Buttons
      bottomSheet: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.download),
              label: const Text("Download Invoice"),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: const Size(double.infinity, 48)),
              onPressed: () {
                // TODO: implement invoice download
              },
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              icon: const Icon(Icons.phone),
              label: const Text("Contact Support"),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  minimumSize: const Size(double.infinity, 48)),
              onPressed: () {
                // TODO: Implement contact logic (e.g., open WhatsApp or dialer)
              },
            ),
            const SizedBox(height: 10),
            OutlinedButton.icon(
              icon: const Icon(Icons.arrow_forward),
              label: const Text("Go to Amenities"),
              style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48)),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const UserAmenitiesPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(String isoDate) {
    try {
      final date = DateTime.parse(isoDate);
      return DateFormat('dd MMM yyyy, hh:mm a').format(date);
    } catch (e) {
      return isoDate;
    }
  }
}
