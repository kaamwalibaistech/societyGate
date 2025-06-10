import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:society_gate/constents/sizedbox.dart';
import 'package:society_gate/models/amenities_model.dart';

import 'bloc/amenities_bloc.dart';
import 'confirm_amenities_buy.dart';

class BookAmenities extends StatefulWidget {
  const BookAmenities({super.key});

  @override
  State<BookAmenities> createState() => _BookAmenitiesState();
}

class _BookAmenitiesState extends State<BookAmenities> {
  AmenitiesModel? amenitiesModel;

  @override
  void initState() {
    super.initState();
    fetchVisitors();
  }

  fetchVisitors() {
    context.read<AllAmenitiesBloc>().add(GetAllAmenities());
  }

  double total = 0;
  String defaultImg = "lib/assets/store.png";
  final List<Map<String, dynamic>> amenitiesImage = [
    {
      'name': 'Club House',
      'image': "lib/assets/club.png",
    },
    {
      'name': 'Swimming Pool',
      'image': "lib/assets/swimming-pool.png",
    },
    {
      'name': 'Garden',
      'image': "lib/assets/garden.png",
    },
    {
      'name': 'Parking',
      'image': "lib/assets/parking.png",
    },
    {
      'name': 'Gym',
      'image': "lib/assets/gym.png",
    },
    {
      'name': 'Playground',
      'image': "lib/assets/playground.png",
    },
    {
      'name': 'Clubhouse',
      'image': "lib/assets/club.png",
    },
    {
      'name': 'Spa',
      'image': "lib/assets/spa.png",
    },
    {
      'name': 'Building Wi-Fi',
      'image': "lib/assets/wifi.png",
    },
    {
      'name': 'Rooftop Garden',
      'image': "lib/assets/roof-top.png",
    },
  ];

  // final Set<String> selectedAmenities = {};
  List<Map<String, String>> selectedAmenitiesList = [];

  Map<String, String> toMap(String name, String price, String duration) {
    return {'amenity_name': name, 'amount': price, 'duration': duration};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: const Text(
          "Choose Amenities",
          style: TextStyle(fontSize: 25, color: Colors.white),
        ),
        backgroundColor: Colors.pink,
        elevation: 0,
        actions: [
          Text(
            "₹ ${total.toString()}",
            style: const TextStyle(fontSize: 25, color: Colors.white),
          ),
          sizedBoxW10(context)
        ],
      ),
      body: Container(
        margin: const EdgeInsets.only(bottom: 50),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 255, 158, 190),
              Color.fromARGB(255, 255, 176, 151)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Book Amenities",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.deepOrange,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    if (total != 0.0) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ConfirmAmenitiesBuy(
                                    selectedAmenitiesList:
                                        selectedAmenitiesList,
                                    total: total,
                                  )));
                      // selectedAmenitiesList = list;
                    } else {
                      Fluttertoast.showToast(
                          backgroundColor: Colors.red,
                          msg: "Please select an amenities!");
                    }
                  },
                  child: const Text("Pay for Amenities"),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<AllAmenitiesBloc, GetAllAmenitiesState>(
                  builder: (context, state) {
                if (state is GetAllAmenitiesInitial ||
                    state is GetAllAmenitiesLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                  // return GridView.count(
                  //   crossAxisCount: 2,
                  //   crossAxisSpacing: 16,
                  //   mainAxisSpacing: 16,
                  //   childAspectRatio: 1,
                  //   children: List.generate(
                  //       4,
                  //       (context) => Container(
                  //             // duration: const Duration(milliseconds: 250),
                  //             decoration: BoxDecoration(
                  //               color: Colors.grey.shade100,
                  //               borderRadius: BorderRadius.circular(16),
                  //             ),
                  //           )),
                  // );
                } else if (state is GetAllAmenitiesSuccess) {
                  return GridView.builder(
                      itemCount: state.amenitiesModel.data?.length ?? 0,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 1,
                      ),
                      itemBuilder: (context, index) {
                        final amenitiesList = state.amenitiesModel.data?[index];

                        bool isSelected = selectedAmenitiesList.any(
                          (item) =>
                              item['amenity_name'] ==
                              amenitiesList?.amenityName,
                        );

                        String getAmenityImage(String amenityName) {
                          final amenity = amenitiesImage.firstWhere(
                            (item) =>
                                item['name']?.toLowerCase() ==
                                amenityName.toLowerCase(),
                            orElse: () => {'image': defaultImg},
                          );
                          return amenity['image'];
                        }

                        return GestureDetector(
                          onTap: () {
                            final ameList = toMap(
                              amenitiesList?.amenityName ?? "",
                              amenitiesList?.amount ?? "",
                              amenitiesList?.duration ?? "",
                            );

                            setState(() {
                              final alreadySelected = selectedAmenitiesList.any(
                                (item) =>
                                    item['amenity_name'] ==
                                    amenitiesList?.amenityName,
                              );

                              if (alreadySelected) {
                                selectedAmenitiesList.removeWhere(
                                  (item) =>
                                      item['amenity_name'] ==
                                      amenitiesList?.amenityName,
                                );
                                total -=
                                    double.parse(amenitiesList?.amount ?? '0');
                              } else {
                                selectedAmenitiesList.add(ameList);
                                total +=
                                    double.parse(amenitiesList?.amount ?? '0');
                              }
                            });

                            log(selectedAmenitiesList.toString());
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Colors.white
                                  : Colors.white.withAlpha(100),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color:
                                    isSelected ? Colors.white : Colors.white60,
                                width: isSelected ? 2 : 1,
                              ),
                              boxShadow: isSelected
                                  ? [
                                      const BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 6,
                                        offset: Offset(2, 2),
                                      )
                                    ]
                                  : [],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 40,
                                  child: Image.asset(
                                    getAmenityImage(
                                        amenitiesList?.amenityName ?? ""),
                                    height: 60,
                                    // width: 60,
                                    // fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  amenitiesList?.amenityName ?? "",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: isSelected
                                        ? Colors.deepOrange
                                        : Colors.black54,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                RichText(
                                    text: TextSpan(
                                        text: "₹${amenitiesList?.amount ?? 0}",
                                        style: TextStyle(
                                            color: isSelected
                                                ? Colors.deepOrange
                                                : Colors.pinkAccent,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                        children: [
                                      TextSpan(
                                        text:
                                            " / ${amenitiesList?.duration ?? ""}",
                                        style: TextStyle(
                                            color: isSelected
                                                ? Colors.deepOrange
                                                : Colors.pinkAccent,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ])),
                              ],
                            ),
                          ),
                        );
                      });
                } else if (state is GetAllAmenitiesFailure) {
                  return const Center(
                      child: Text(
                    "Your Society does not providing any amenities!",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ));
                } else {
                  return const Text("No amenities found in your society!");
                }
              }),
            ),
            /*  ,*/
          ],
        ),
      ),
    );
  }
}
