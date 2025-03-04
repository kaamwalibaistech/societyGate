import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomepageScreen extends StatelessWidget {
  const HomepageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> title = [
      "Members",
      "Visitors",
      "Notice Board",
      "Payment",
      "Book amenities",
      "Help desk"
    ];
    List<String> subtitle = [
      "connect society member",
      "manage visitors entry",
      "society announcement & event notice",
      "direct payment of society due",
      "pre book society amenities",
      "complaint & suggestion"
    ];
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 241, 237, 237),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light
            .copyWith(statusBarColor: Theme.of(context).primaryColor),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: const BoxDecoration(color: Colors.white),
                  height: MediaQuery.of(context).size.height * 0.38,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Theme.of(context).primaryColor,
                            radius: 30,
                          ),
                          title: const Text("Hi Ritesh Dixit"),
                          subtitle: const Text("F-101 | Shubham Complex"),
                          trailing: const Icon(Icons.notification_add),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 18.0, right: 18, top: 6),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(10)),
                          height: MediaQuery.of(context).size.height * 0.18,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 22.0, top: 20),
                        child: Text(
                          "Community",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 510,
                  child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 6,
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              // mainAxisSpacing: 10,
                              // crossAxisSpacing: 20,
                              mainAxisExtent: 170,
                              crossAxisCount: 2),
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 12),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 8.0, top: 10),
                                  child: Text(
                                    title[index],
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 8.0, top: 2),
                                  child: Text(
                                    subtitle[index],
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
