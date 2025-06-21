import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../api/api_repository.dart';
import '../constents/local_storage.dart';
import '../constents/sizedbox.dart';
import '../dashboard/visitors/visitors_bloc/visitors_bloc.dart';
import 'manual_visitors_form.dart';

class ManualVisitorsScreen extends StatefulWidget {
  const ManualVisitorsScreen({super.key});

  @override
  State<ManualVisitorsScreen> createState() => _ManualVisitorsScreenState();
}

class _ManualVisitorsScreenState extends State<ManualVisitorsScreen> {
  // LoginModel? loginModel;
  // AddVisitoModel? _addVisitoModel;
  @override
  void initState() {
    super.initState();
    // fetchVisitors();
    context.read<VisitorsBloc>().add(GetEnteredVisitorsEvent());
  }

  // fetchVisitors() {
  //   final loginModelStorage = LocalStoragePref().getLoginModel();

  //   setState(() {
  //     loginModel = loginModelStorage;
  //   });
  //   if (loginModel != null) {
  //     final societyId = loginModel?.user?.societyId;
  //     final flatId = loginModel?.user?.flatId;

  //     context.read<VisitorsBloc>().add(GetVisitorsEvent(
  //         soceityId: societyId.toString(), flatId: flatId.toString()));
  //   } else {
  //     log("LoginModel not found in local storage.");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ManualVisitorsForm()));
              },
              child: Container(
                  margin: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 1, color: Colors.greenAccent),
                      color: Colors.amber.shade50,
                      boxShadow: [
                        BoxShadow(
                            offset: const Offset(0, 1),
                            spreadRadius: 2,
                            blurRadius: 5,
                            color: Colors.amber.shade100)
                      ]),
                  height: MediaQuery.of(context).size.height * 0.10,
                  width: MediaQuery.of(context).size.width,
                  child: const Center(child: Text("Add Manual Visitor"))),
            ),
            BlocBuilder<VisitorsBloc, VisitorsState>(
              // buildWhen: (previous, current) {
              //   return current is VisitorsSuccessState;
              // },
              builder: (context, state) {
                if (state is VisitorsSuccessState) {
                  return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: state.getManualvisitorsList?.length,
                      shrinkWrap: true,
                      itemBuilder: ((context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            color: Colors.amber,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListTile(
                                    trailing: GestureDetector(
                                        onTap: () async {
                                          final loginModel = LocalStoragePref()
                                              .getLoginModel();

                                          ApiRepository apiRepository =
                                              ApiRepository();
                                          final data = await apiRepository
                                              .manualAproveApi(
                                                  state.getManualvisitorsList?[
                                                              index]
                                                              ["unique_code"]
                                                          .toString() ??
                                                      "",
                                                  loginModel!.user!.userId
                                                      .toString(),
                                                  "exit");
                                          BlocProvider.of<VisitorsBloc>(context)
                                              .add(GetEnteredVisitorsEvent());
                                        },
                                        child: const Icon(Icons.exit_to_app)),
                                    leading: const CircleAvatar(
                                      foregroundImage:
                                          AssetImage("lib/assets/qr.jpg"),
                                      radius: 30,
                                    ),
                                    title: Text(
                                        '${state.getManualvisitorsList?[index]["name"]}'),
                                    subtitle: Text(
                                        '${state.getManualvisitorsList?[index]["phone"]}'),
                                  ),
                                ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        '${state.getManualvisitorsList?[index]["relation"]}' ??
                                            "Not available",
                                        style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.blueGrey),
                                      ),
                                      sizedBoxW5(context),
                                      const SizedBox(
                                        height: 10,
                                        child: VerticalDivider(
                                          color: Colors.blueGrey,
                                          thickness: 1,
                                          width: 20,
                                        ),
                                      ),
                                      sizedBoxW5(context),
                                      Text(
                                        '${state.getManualvisitorsList?[index]["visiting_purpose"]}' ??
                                            "Not available",
                                        style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.blueGrey),
                                      ),
                                      //   sizedBoxW5(context),

                                      sizedBoxW5(context),
                                    ]),
                                sizedBoxH5(context)
                              ],
                            ),
                          ),
                        );
                      }));
                }
                return const Text("No visitors");
              },
            ),
            // Padding(
            //   padding: const EdgeInsets.only(top: 250.0),
            //   child: Text(loginModel?.user?.uname.length.toString() ?? ""),
            // )
          ],
        ),
      ),
    );
  }
}
