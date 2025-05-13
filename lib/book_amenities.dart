import 'package:flutter/material.dart';

class BookAmenities extends StatefulWidget {
  const BookAmenities({super.key});

  @override
  State<BookAmenities> createState() => _BookAmenitiesState();
}

class _BookAmenitiesState extends State<BookAmenities> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 19, 52, 84),
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        title: const Text(
          "Book amenities",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: const Center(
        child: Text("Coming Soon"),
      ),
    );
  }
}
