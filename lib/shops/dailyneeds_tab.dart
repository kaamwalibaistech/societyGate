import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:society_gate/shops/bloc/dailyneeds_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constents/local_storage.dart';
import '../models/login_model.dart';
import '../models/shoplist_model.dart';
import 'shopsettings.dart';

class DailyneedsTab extends StatefulWidget {
  const DailyneedsTab({super.key});

  @override
  State<DailyneedsTab> createState() => DailyneedsTabState();
}

class DailyneedsTabState extends State<DailyneedsTab> {
  late String admin;
  @override
  void initState() {
    super.initState();
    context.read<DailyneedsBloc>().add(GetShopsList());
    LoginModel? loginModel = LocalStoragePref().getLoginModel();
    admin = loginModel!.user!.role.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange.shade50,
          // automaticallyImplyLeading: false,
          title: const Text(
            "DAILY NEEDS",
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey),
          ),
          centerTitle: true,
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ShopSettings()));
              },
              child: Visibility(
                visible: admin == "admin",
                child: const Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Icon(
                    Icons.settings,
                    color: Colors.deepOrangeAccent,
                  ),
                ),
              ),
            )
          ],
        ),
        body: BlocBuilder<DailyneedsBloc, DailyneedsState>(
            builder: (context, state) {
          if (state is DailyneedsInitial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is DailyneedsSuccessState) {
            return buildSuccessWidget(state.shopListModel);
          } else if (state is DailyneedsSuccessState) {
            return buildErrorWidget();
          } else {
            return buildErrorWidget();
          }
        }));
  }

  Widget buildErrorWidget() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 200.0),
          child: Image.asset("lib/assets/empty.jpg"),
        ),
        const Text("Cutrrently No shops available!")
      ],
    );
  }

  Widget buildSuccessWidget(ShopListModel? shopListModel) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: shopListModel!.data!.isNotEmpty
            ? GridView.builder(
                itemCount: shopListModel.data?.length ?? 0,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 20,
                  childAspectRatio: 0.7,
                ),
                itemBuilder: (context, index) {
                  final shop = shopListModel.data?[index];
                  String fullName = shop?.shopName ?? "Shop";
                  List<String> nameParts = fullName.split(" ");

                  String firstName = nameParts.isNotEmpty ? nameParts[0] : "";
                  String lastName = nameParts.length > 1 ? nameParts[1] : "";

                  return Card(
                    // color: Colors.amber,
                    shadowColor: Colors.green.shade50,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            shop?.image ??
                                'https://ui-avatars.com/api/?name=$firstName+$lastName&background=random&bold=true',
                            height: MediaQuery.of(context).size.height * 0.135,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            children: [
                              Text(
                                overflow: TextOverflow.ellipsis,
                                shop?.shopName ?? "N/A",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              // const SizedBox(height: 2),
                              Text(
                                shop?.shopType ?? "N/A",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.red,
                                ),
                              ),
                              Text(
                                shop?.address ?? "N/A",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.green.shade700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // const SizedBox(height: 6),
                        GestureDetector(
                            onTap: () {
                              int num = int.parse(
                                  shopListModel.data?[index].phone.toString() ??
                                      "");
                              final phoneUri = Uri(
                                scheme: 'tel',
                                path: "$num",
                              );
                              launchUrl(phoneUri);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              margin: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height * 0.05,
                              decoration: BoxDecoration(
                                  color: Colors.green.shade100,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Contact",
                                    style: TextStyle(color: Colors.black87),
                                  ),
                                  Lottie.asset(
                                    'lib/assets/lottie_json/call.json',
                                  )
                                ],
                              ),
                            )
                            // Container(
                            //   margin: EdgeInsets.only(left: 10),
                            //   padding: EdgeInsets.all(5),
                            //   decoration: BoxDecoration(
                            //       color: Colors.blue,
                            //       borderRadius: BorderRadius.circular(100)),
                            //   child: Icon(
                            //     Icons.call,
                            //     color: Colors.white,
                            //   ),
                            // ),
                            ),
                      ],
                    ),
                  );
                },
              )
            : const Center(child: Text("No Shops Added")));
  }
}
