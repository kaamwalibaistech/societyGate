import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:society_gate/account_tab/settings_pages/help_support.dart';
import 'package:society_gate/constents/sizedbox.dart';
import 'package:society_gate/homepage_screen.dart';
import 'package:society_gate/models/amenities_buy_done.dart';
import 'package:society_gate/models/amenities_ceate_order.dart';
import 'package:society_gate/amenities/user_amenities_page.dart';

import 'amenities_images.dart';

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
        title: const Text("Booking Successful"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 16,
              bottom: MediaQuery.of(context).viewPadding.bottom * 6.5,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.check_circle_rounded,
                        color: Colors.green, size: 30),
                    SizedBox(width: 10),
                    Text(
                      "Booking Confirmed!",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                /// PAYMENT DETAILS
                Text("Payment Details",
                    style: Theme.of(context).textTheme.titleMedium),
                const Divider(height: 24),
                _buildPaymentInfoTile("Payment ID", paymentId),
                _buildPaymentInfoTile("Order ID", order?.orderId),
                _buildPaymentInfoTile("Amount Paid",
                    "₹ ${(order?.amount ?? 0) / 100} ${order?.currency ?? ''}"),
                _buildPaymentInfoTile(
                    "Receipt ID", order?.fullResponse?['receipt']),

                const SizedBox(height: 24),

                /// BOOKED AMENITIES
                Text("Booked Amenities",
                    style: Theme.of(context).textTheme.titleMedium),
                const Divider(height: 24),
                ...bookings.map(
                  (amenity) => Card(
                    elevation: 1,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 12),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          getAmenityImage("Club House"),
                          width: 48,
                          height: 48,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: const Text(
                        "Amenity",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _infoRow(Icons.access_time_rounded,
                                "Duration: ${amenity.duration}"),
                            const SizedBox(height: 2),
                            _infoRow(Icons.play_arrow_rounded,
                                "Start: ${_formatDate(amenity.startTime ?? '')}",
                                iconColor: Colors.green),
                            const SizedBox(height: 2),
                            _infoRow(Icons.stop_rounded,
                                "End: ${_formatDate(amenity.endTime ?? '')}",
                                iconColor: Colors.red),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              const BoxShadow(
                color: Colors.black12,
                blurRadius: 12,
                offset: Offset(0, -2),
              ),
            ],
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.download_rounded),
                      label: const Text("Invoice"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade600,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () {
                        // TODO: Download invoice
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.headset_mic_rounded),
                      label: const Text("Support"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange.shade600,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const HelpSupport()));
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size.fromHeight(48),
                  side: BorderSide(color: Colors.indigo.shade400, width: 1.4),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const UserAmenitiesPage()),
                  );
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Go to Amenities",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.indigo,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward_ios_rounded,
                        size: 16, color: Colors.indigo),
                  ],
                ),
              ),
              sizedBoxH20(context)
            ],
          ),
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

  /// Helper widget for info rows inside ListTile subtitle
  Widget _infoRow(IconData icon, String text, {Color iconColor = Colors.blue}) {
    return Row(
      children: [
        Icon(icon, size: 16, color: iconColor),
        const SizedBox(width: 4),
        Flexible(
          child: Text(
            text,
            style: const TextStyle(fontSize: 13),
          ),
        ),
      ],
    );
  }

  /// Helper for uniform payment details
  Widget _buildPaymentInfoTile(String title, String? value) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
      subtitle: Text(value ?? 'N/A'),
      dense: true,
      visualDensity: VisualDensity.compact,
    );
  }
}
