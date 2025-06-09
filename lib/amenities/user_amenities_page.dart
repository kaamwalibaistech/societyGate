import 'package:flutter/material.dart';
import 'package:society_gate/api/api_repository.dart';
import 'package:society_gate/constents/local_storage.dart';
import 'package:society_gate/models/get_user_purchase_amenities_model.dart';

class UserAmenitiesPage extends StatefulWidget {
  final List<String> amenities;

  const UserAmenitiesPage({super.key, required this.amenities});

  @override
  State<UserAmenitiesPage> createState() => _UserAmenitiesPageState();
}

class _UserAmenitiesPageState extends State<UserAmenitiesPage> {
  GetUserPurchaseAmenitiesModel? getUserPurchaseAmenitiesData;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  _getData() async {
    final data = LocalStoragePref.instance!.getLoginModel();
    ApiRepository apiRepository = ApiRepository();
    getUserPurchaseAmenitiesData =
        await apiRepository.getFamilyMemGetUserPurchaseAmenities(
            data!.user!.societyId.toString(), data.user?.userId.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Amenities"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: getUserPurchaseAmenitiesData?.data == null
          ? const Center(
              child: Text(
                "No amenities added yet.",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: getUserPurchaseAmenitiesData?.data?.length ?? 0,
              itemBuilder: (context, index) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Amenity Image
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            'lib/assets/swimming-pool.png', // Replace with your image URL
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Text Info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.amenities[index], // Amenity name
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                getUserPurchaseAmenitiesData!
                                        .data?[index].duration
                                        .toString() ??
                                    "",
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.grey),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                getUserPurchaseAmenitiesData!
                                        .data?[index].amount
                                        .toString() ??
                                    "",
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.arrow_forward_ios,
                            size: 16, color: Colors.grey),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
