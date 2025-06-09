import 'package:flutter/material.dart';

class ConfirmAmenitiesBuy extends StatefulWidget {
  final List<Map<String, String>> selectedAmenitiesList;
  final double total;

  const ConfirmAmenitiesBuy({
    super.key,
    required this.selectedAmenitiesList,
    required this.total,
  });

  @override
  State<ConfirmAmenitiesBuy> createState() => _ConfirmAmenitiesBuyState();
}

class _ConfirmAmenitiesBuyState extends State<ConfirmAmenitiesBuy> {
  bool isTermsAccepted = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Confirm Bookings"),
        backgroundColor: Colors.pinkAccent,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: widget.selectedAmenitiesList.length,
                itemBuilder: (context, index) {
                  final item = widget.selectedAmenitiesList[index];
                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: const Icon(Icons.room_preferences,
                          color: Colors.pink),
                      title: Text(
                        item['amenity_name'] ?? 'No name',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      subtitle: Text(
                        "₹${item['amount'] ?? '0'} / ${item['duration'] ?? ''}",
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 50),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0, -1),
                      blurRadius: 5)
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Total Amount:",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600)),
                      Text(
                        "₹${widget.total.toStringAsFixed(2)}",
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.pink),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: const Icon(
                        Icons.payment,
                        color: Colors.white,
                      ),
                      label: const Text(
                        "Proceed to Pay",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pinkAccent,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      onPressed: isTermsAccepted
                          ? () {
                              // Add your payment logic here
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor: Colors.greenAccent,
                                  content: Text(
                                    "Proceeding to payment...",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              );
                            }
                          : null,
                    ),
                  ),
                  // sizedBoxH20(context),
                  // const Center(
                  //   child: Text(
                  //     "By continue, you accepted the Terms and Conditions",
                  //     style: TextStyle(
                  //         fontSize: 14,
                  //         color: Colors.blueAccent,
                  //         decoration: TextDecoration.underline,
                  //         fontStyle: FontStyle.italic),
                  //   ),
                  // ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
