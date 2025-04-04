import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../constents/sizedbox.dart';
import '../models/shoplist_model.dart';
import 'addshop.dart';
import 'bloc/dailyneeds_bloc.dart';
import 'editShop.dart';
import 'network/shop_apis.dart';

class ShopSettings extends StatefulWidget {
  const ShopSettings({super.key});

  @override
  State<ShopSettings> createState() => _ShopSettingsState();
}

class _ShopSettingsState extends State<ShopSettings> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) async {
        context.read<DailyneedsBloc>().add(GetShopsList());
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlue.shade100,
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: GestureDetector(
            onTap: () {
              context.read<DailyneedsBloc>().add(GetShopsList());
              Navigator.pop(context);
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 32),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(width: 1, color: Colors.blue),
                  color: Colors.white),
              child: const Icon(
                Icons.arrow_back,
                color: Colors.blue,
              ),
            ),
          ),
          toolbarHeight: 100,
          title: const Text(
            "Manage Daily Needs",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: Colors.black87),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              listTile(Icons.add_business_outlined, "  Add shop", 'addShop'),
              sizedBoxH5(context),
              listTile(Icons.edit, "  Edit shop", 'edit'),
              sizedBoxH5(context),
              listTile(Icons.delete, "  Delete shop", 'delete'),
              listTile(Icons.warning_amber_rounded, "  Report a shop", ''),
              sizedBoxH5(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget listTile(IconData icon, String text, String action) {
    return GestureDetector(
      onTap: () {
        if (action == 'delete') {
          editDeleteShop("delete");
        } else if (action == 'edit') {
          editDeleteShop("edit");
        } else if (action == 'addShop') {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddShop()));
        } else {
          Fluttertoast.showToast(
              msg: "Currently, we are working on this feature!");
        }
      },
      child: Card(
        elevation: 0,
        child: ListTile(
          leading: Icon(
            icon,
            size: 25,
          ),
          title: Text(
            text,
            style: const TextStyle(fontSize: 18),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 20,
          ),
        ),
      ),
    );
  }

  editDeleteShop(String action) async {
    context.read<DailyneedsBloc>().add(GetShopsList());
    return await showDialog<bool>(
        context: context,
        builder: (context) {
          return Container(
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: [
                  sizedBoxH5(context),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      "Please select shop to $action",
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.75,
                    child: BlocBuilder<DailyneedsBloc, DailyneedsState>(
                        builder: (context, state) {
                      if (state is DailyneedsInitial) {
                        return const CircularProgressIndicator();
                      } else if (state is DailyneedsSuccessState) {
                        return buildDeleteWidget(state.shopListModel, action);
                      } else if (state is DailyneedsSuccessState) {
                        return const Center(
                          child: Text("Error"),
                        );
                      } else {
                        return const Center(
                          child: Text("Error"),
                        );
                      }
                    }),
                  ),
                ],
              ));
        });
  }

  Widget buildDeleteWidget(ShopListModel? shopListModel, String action) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: GridView.builder(
        itemCount: shopListModel?.data?.length ?? 0,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 20,
          childAspectRatio: 0.8,
        ),
        itemBuilder: (context, index) {
          final shop = shopListModel?.data?[index];
          String fullName = shop?.shopName ?? "Shop";
          List<String> nameParts = fullName.split(" ");

          String firstName = nameParts.isNotEmpty ? nameParts[0] : "";
          String lastName = nameParts.length > 1 ? nameParts[1] : "";

          return GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
              if (action == "edit") {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Editshop(
                            shopListModel: shopListModel, index: index)));
              } else {
                deleteShopDialog(shopListModel, index);
              }
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundImage: NetworkImage(
                      'https://ui-avatars.com/api/?name=$firstName+$lastName&background=random&bold=true',
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: Text(
                      shop?.shopName ?? "N/A",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    shop?.name ?? "N/A",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  deleteShopDialog(ShopListModel? shopListModel, int index) async {
    context.read<DailyneedsBloc>().add(GetShopsList());
    final shop = shopListModel?.data?[index];
    String fullName = shop?.shopName ?? "Shop";
    List<String> nameParts = fullName.split(" ");

    String firstName = nameParts.isNotEmpty ? nameParts[0] : "";
    String lastName = nameParts.length > 1 ? nameParts[1] : "";
    return await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Confirm Delete"),
              content: SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundImage: NetworkImage(
                        'https://ui-avatars.com/api/?name=$firstName+$lastName&background=random&bold=true',
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      shop?.shopName ?? "N/A",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      shop?.name ?? "N/A",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    // Fluttertoast.showToast(msg: "ddd");
                    Navigator.of(context).pop();
                  },
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: () async {
                    String? shopId =
                        shopListModel?.data?[index].shopId.toString();
                    // context
                    //     .read<DailyneedsBloc>()
                    //     .add(DeleteShopEvent(shopId: shopId ?? ""));

                    int? status;
                    try {
                      status = await deleteShopAPI(shopId.toString());
                      if (status == 200) {
                        Fluttertoast.showToast(
                            msg: "Shop deleted successfully.");
                        Navigator.of(context).pop();
                      } else {
                        Fluttertoast.showToast(msg: "Shop not found!");
                        Navigator.of(context).pop();
                      }
                    } catch (e) {
                      Fluttertoast.showToast(
                          msg: "Something wrong, Please try again!");
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text("Delete"),
                ),
              ],
            ));
  }
}
