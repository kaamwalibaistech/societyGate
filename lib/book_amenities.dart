import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:society_gate/constents/sizedbox.dart';

class BookAmenities extends StatefulWidget {
  const BookAmenities({super.key});

  @override
  State<BookAmenities> createState() => _BookAmenitiesState();
}

class _BookAmenitiesState extends State<BookAmenities> {
  int total = 0;
  final List<Map<String, dynamic>> amenities = [
    {
      'name': 'Swimming Pool',
      'price': 500,
      'image': "lib/assets/swimming-pool.png",
    },
    {
      'name': 'Garden',
      'price': 300,
      'image': "lib/assets/garden.png",
    },
    {
      'name': 'Parking',
      'price': 200,
      'image': "lib/assets/parking.png",
    },
    {
      'name': 'Gym',
      'price': 400,
      'image': "lib/assets/gym.png",
    },
    {
      'name': 'Playground',
      'price': 250,
      'image': "lib/assets/playground.png",
    },
    {
      'name': 'Club House',
      'price': 600,
      'image': "lib/assets/club.png",
    },
    {
      'name': 'Spa',
      'price': 450,
      'image': "lib/assets/spa.png",
    },
    {
      'name': 'Building Wi-Fi',
      'price': 150,
      'image': "lib/assets/wifi.png",
    },
    {
      'name': 'Rooftop Garden',
      'price': 350,
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
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1,
                children: amenities.map((amenity) {
                  final isSelected =
                      selectedAmenities.contains(amenity['name']);
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          selectedAmenities.remove(amenity['name']);
                        } else {
                          selectedAmenities.add(amenity['name']);
                        }
                        total = total +
                            (isSelected
                                ? -amenity['price']
                                : amenity['price']) as int;
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
                          color: isSelected ? Colors.white : Colors.white60,
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
                              amenity['image'],
                              height: 60,
                              // width: 60,
                              // fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            amenity['name'],
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
                                  text: "₹${amenity['price']}",
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
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
