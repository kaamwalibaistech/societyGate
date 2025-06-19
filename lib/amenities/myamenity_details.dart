import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:society_gate/models/get_user_purchase_amenities_model.dart';

import 'amenities_images.dart';

class MyAmenityDetails extends StatefulWidget {
  final AmenityPurchaseData data;
  const MyAmenityDetails({super.key, required this.data});

  @override
  State<MyAmenityDetails> createState() => _MyAmenityDetailsState();
}

class _MyAmenityDetailsState extends State<MyAmenityDetails> {
  String formatDate(String? dateStr) {
    if (dateStr == null) return '';
    final date = DateTime.tryParse(dateStr);
    return date != null ? DateFormat('dd MMM yyyy – hh:mm a').format(date) : '';
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.data;

    return Scaffold(
      appBar: AppBar(
        title: Text(data.amenity?.name ?? "Amenity Details"),
        backgroundColor: Colors.pinkAccent,
        foregroundColor: Colors.white,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        color: Colors.pink.shade50,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildDetailCard(
                icon: Icons.home,
                title: 'Amenity Name',
                value: data.amenity?.name ?? 'N/A',
                isName: true),
            buildDetailCard(
              icon: Icons.access_time,
              title: 'Amenity Duration',
              value: data.amenity?.duration ?? 'N/A',
            ),
            buildDetailCard(
              icon: Icons.monetization_on,
              title: 'Amenity Amount',
              value: '₹${data.amenity?.amount ?? '0'}',
            ),
            const Divider(height: 30),
            buildDetailCard(
              icon: Icons.timelapse,
              title: 'Purchased Duration',
              value: data.duration ?? 'N/A',
            ),
            buildDetailCard(
              icon: Icons.calendar_today,
              title: 'Start Time',
              value: formatDate(data.startTime),
            ),
            buildDetailCard(
              icon: Icons.event_available,
              title: 'End Time',
              value: formatDate(data.endTime),
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                label: const Text(
                  'Back',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () => Navigator.pop(context),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildDetailCard({
    required IconData icon,
    required String title,
    required String value,
    bool isName = false,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: !isName
            ? Icon(icon, color: Colors.pink)
            : Image.asset(getAmenityImage(value)),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        subtitle: Text(
          value,
          style: TextStyle(color: Colors.pink.shade700, fontSize: 14),
        ),
      ),
    );
  }
}
