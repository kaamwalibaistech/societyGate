import 'package:flutter/material.dart';
import 'package:society_gate/amenities/myamenity_details.dart';
import 'package:society_gate/api/api_repository.dart';
import 'package:society_gate/constents/date_format.dart';
import 'package:society_gate/constents/local_storage.dart';
import 'package:society_gate/models/get_user_purchase_amenities_model.dart';

import 'amenities_images.dart';

class UserAmenitiesPage extends StatefulWidget {
  // final List<String> amenities;

  const UserAmenitiesPage({
    super.key,
    // required this.amenities
  });

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
    final amenitiesData = await apiRepository.getUserPurchaseAmenities(
        data!.user!.societyId.toString(), data.user?.userId.toString());
    setState(() {
      getUserPurchaseAmenitiesData = amenitiesData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("My Amenities"),
          centerTitle: true,
          backgroundColor: Colors.pinkAccent,
          foregroundColor: Colors.white,
        ),
        body: getUserPurchaseAmenitiesData?.data == null
            ? const Center(
                child: CircularProgressIndicator(
                color: Colors.pinkAccent,
              ))
            : getUserPurchaseAmenitiesData!.status == 200
                ? ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: getUserPurchaseAmenitiesData?.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyAmenityDetails(
                                    data: getUserPurchaseAmenitiesData!
                                        .data![index]))),
                        child: Card(
                          // color: Colors.pink.shade50,
                          surfaceTintColor: Colors.pink.shade50,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
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
                                    getAmenityImage(
                                        getUserPurchaseAmenitiesData!
                                                .data![index].amenity?.name ??
                                            ""), // Replace with your image URL
                                    width: 70,
                                    height: 70,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                // Text Info
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        getUserPurchaseAmenitiesData!
                                                .data![index].amenity?.name ??
                                            "", // Amenity name
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        "• End at:  ${formatDate(getUserPurchaseAmenitiesData!.data?[index].endTime ?? "".toString())} ",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.red.shade300),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        "  Plan: ${getUserPurchaseAmenitiesData!.data?[index].duration.toString() ?? "NA"}",
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
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
                        ),
                      );
                    },
                  )
                : const Center(child: Text("No amenities Purchased")));
  }
}
