import 'package:flutter/material.dart';

import '../../models/homepage_model.dart';

class NoticeBoardScreen extends StatefulWidget {
  final Homepagemodel? data;

  const NoticeBoardScreen({super.key, required this.data});

  @override
  State<NoticeBoardScreen> createState() => _NoticeBoardScreenState();
}

class _NoticeBoardScreenState extends State<NoticeBoardScreen> {
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
        backgroundColor: const Color.fromARGB(255, 19, 52, 84),
        title: const Text(
          "All Notices",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        elevation: 10,
      ),
      body: ListView.builder(
          itemCount: widget.data!.data.announcements.length,
          itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 19, 52, 84),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Text(
                              textAlign: TextAlign.center,
                              widget.data!.data.announcements[index].title,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Text(
                          // maxLines: 2,
                          // overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          widget.data!.data.announcements[index].description,
                          style: const TextStyle(color: Colors.white),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                textAlign: TextAlign.center,
                                "Created At : ${widget.data!.data.announcements[index].createdAt}"
                                    .toString(),
                                style: const TextStyle(color: Colors.white),
                              ),
                              Text(
                                textAlign: TextAlign.center,
                                widget.data!.data.announcements[index]
                                    .announcementType,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )),
    );
  }
}
