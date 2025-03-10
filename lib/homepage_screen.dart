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
    List<String> communityList = [
      'lib/assets/members.png',
      'lib/assets/visitors.png',
      'lib/assets/mood-board.png',
      'lib/assets/payment.png',
      'lib/assets/ameneties.png',
      'lib/assets/help_desk.png',
    ];
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 235, 245, 255),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light
            .copyWith(statusBarColor: Theme.of(context).primaryColor),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(color: Colors.red.shade50),
                  height: MediaQuery.of(context).size.height * 0.38,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: ListTile(
                          leading: CircleAvatar(
                            foregroundImage: AssetImage("lib/assets/man.png"),
                            radius: 30,
                          ),
                          title: const Text("Hi Ritesh Dixit"),
                          subtitle: const Text("F-101 | Shubham Complex"),
                          trailing: Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(color: Colors.red)),
                            child: const Icon(
                              Icons.notifications_active,
                              color: Colors.redAccent,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 18.0, right: 18, top: 18),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.18,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.red,
                              ),
                              borderRadius: BorderRadius.circular(10)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              "lib/assets/society.jpg",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 22.0, top: 20),
                        child: Text(
                          "Community",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.red.shade900),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 590,
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
                              horizontal: 15.0, vertical: 18),
                          child: Stack(children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.green.shade100,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 8.0,
                                      top: 10,
                                    ),
                                    child: Text(
                                      title[index],
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, top: 2, right: 8),
                                    child: Text(
                                      subtitle[index],
                                      style: const TextStyle(
                                          color: Colors.blueGrey),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              bottom: 12,
                              right: 18,
                              child: Image.asset(
                                communityList[index],
                                // scale: 35,
                              ),
                            )
                          ]),
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
