import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:society_gate/constents/sizedbox.dart';
import 'package:society_gate/models/amenities_model.dart';

import 'bloc/amenities_bloc.dart';

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

  int total = 0;
  String DefaultImg = "lib/assets/help_desk.png";
  final List<Map<String, dynamic>> amenitiesImage = [
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

  final Set<String> selectedAmenities = {};

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
                    // final selected = selectedAmenities.toList();
                    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    //   content: Text("Selected: ${selected.join(', ')}"),
                    // ));
                    Fluttertoast.showToast(msg: "Working on This");
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
                  return GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1,
                    children: List.generate(
                        6,
                        (context) => Container(
                              // duration: const Duration(milliseconds: 250),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(16),
                              ),
                            )),
                  );
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
                        final isSelected = selectedAmenities
                            .contains(amenitiesList?.amenityName ?? "");

                        bool imageName = amenitiesImage[index]['name']
                            .contains(amenitiesList?.amenityName ?? "");
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              // if (isSelected) {
                              //   selectedAmenities.remove(amenity['name']);
                              // } else {
                              //   selectedAmenities.add(amenity['name']);
                              // }
                              // total = total +
                              //     (isSelected
                              //         ? -amenity['price']
                              //         : amenity['price']) as int;
                            });
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
                                    imageName == true
                                        ? amenitiesImage[index]['image']
                                        : DefaultImg,
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
                                        text: " /month",
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
                  return const Text("data");
                } else {
                  return const Text("data");
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
