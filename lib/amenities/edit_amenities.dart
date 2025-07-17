import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:society_gate/amenities/amenities_add.dart';
import 'package:society_gate/amenities/amenities_images.dart';
import 'package:society_gate/amenities/network/amenities_apis.dart';
import 'package:society_gate/constents/sizedbox.dart';
import 'package:society_gate/models/amenities_model.dart';

import 'bloc/amenities_bloc.dart';

class EditAmenities extends StatefulWidget {
  const EditAmenities({super.key});

  @override
  State<EditAmenities> createState() => _EditAmenitiesState();
}

class _EditAmenitiesState extends State<EditAmenities> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  bool _isExpanded = false;
  late int clickedIndex;
  String? duration;
  final List<String> durations = [
    'Monthly',
    '3 Months',
    '6 Months',
    'Yearly',
  ];

  @override
  void initState() {
    super.initState();
    context.read<AllAmenitiesBloc>().add(GetAllAmenities());
  }

  void _toggleCard(int index) {
    setState(() {
      _isExpanded = !_isExpanded;
      clickedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose Amenities"),
        backgroundColor: Colors.pink.shade400,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
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
        child: Column(children: [
          SizedBox(
            width: double.maxFinite,
            child: GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AmenitiesAdd(
                            commingFrom: "editAmenities",
                          ))),
              child: Card(
                  margin: const EdgeInsets.only(bottom: 20),
                  elevation: 10,
                  color: Colors.white,
                  shadowColor: Colors.black38,
                  child: DottedBorder(
                    // borderPadding: const EdgeInsets.all(12),
                    color: Colors.red.shade300,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 20),
                    strokeWidth: 2,
                    dashPattern: const [5, 3],
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(12),
                    child: const Center(
                      child: Column(children: [
                        Icon(Icons.add_box_outlined,
                            size: 36, color: Colors.red),
                        SizedBox(height: 12),
                        Text(
                          "Click here to add more amenities!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ]),
                    ),
                  )),
            ),
          ),
          Expanded(
            child: BlocBuilder<AllAmenitiesBloc, GetAllAmenitiesState>(
                builder: (context, state) {
              if (state is GetAllAmenitiesInitial ||
                  state is GetAllAmenitiesLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.pinkAccent,
                  ),
                );
              } else if (state is GetAllAmenitiesSuccess) {
                return ListView.builder(
                    itemCount: state.amenitiesModel.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      String amenityName =
                          state.amenitiesModel.data?[index].amenityName ?? "";
                      return GestureDetector(
                        onTap: () => _toggleCard(index),
                        child: Card(
                          elevation: 1,
                          color: Colors.white,
                          child: Column(
                            children: [
                              ListTile(
                                contentPadding: const EdgeInsets.all(10),
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.asset(
                                    getAmenityImage(amenityName),
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                title: Text(
                                  amenityName,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                    "${state.amenitiesModel.data?[index].amount ?? ''}  |  ${state.amenitiesModel.data?[index].duration ?? ''}"),
                                trailing: Icon(
                                  _isExpanded
                                      ? Icons.keyboard_arrow_up_rounded
                                      : Icons.keyboard_arrow_down_rounded,
                                ),
                              ),
                              if (_isExpanded && clickedIndex == index)
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton.icon(
                                        onPressed: () => editDialog(
                                            state.amenitiesModel.data?[index]),
                                        icon: const Icon(Icons.edit,
                                            color: Colors.blue),
                                        label: const Text("Edit",
                                            style:
                                                TextStyle(color: Colors.blue)),
                                      ),
                                      const SizedBox(width: 10),
                                      TextButton.icon(
                                        onPressed: () => showDeleteConfirmation(
                                            state.amenitiesModel.data?[index]),
                                        icon: const Icon(Icons.delete,
                                            color: Colors.red),
                                        label: const Text("Delete",
                                            style:
                                                TextStyle(color: Colors.red)),
                                      ),
                                    ],
                                  ),
                                ),
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
        ]),
      ),
    );
  }

  void showDeleteConfirmation(Data? data) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Amenity"),
        content: const Text("Are you sure you want to delete this amenity?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              EasyLoading.show();
              Map<String, dynamic>? deleteApiData =
                  await deleteAmenitiesApi(data?.amenityId.toString() ?? "");
              if (deleteApiData?['status'] == 200) {
                EasyLoading.showSuccess(deleteApiData?['message']);
                context.read<AllAmenitiesBloc>().add(GetAllAmenities());
                Navigator.pop(context);
              } else {
                EasyLoading.showError(
                    deleteApiData?['message'] ?? "Something went wrong!");
                Navigator.pop(context);
              }
            },
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void editDialog(Data? data) {
    duration = data?.duration ?? "Select";

    _nameController.text = data?.amenityName ?? "";
    _priceController.text = data?.amount ?? "";
    // _durationController.text = data?.duration ?? "";

    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      backgroundColor: const Color.fromARGB(255, 255, 158, 190),
      // shape: const RoundedRectangleBorder(
      //   borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      // ),
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Text(
                "Edit Amenity",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              sizedBoxH20(context),
              Card(
                color: Colors.white,
                child: ListTile(
                  contentPadding: const EdgeInsets.all(10),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      getAmenityImage(data?.amenityName ?? ""),
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(
                    data?.amenityName ?? "",
                    style: const TextStyle(
                      // fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    data?.duration ?? "",
                    style: const TextStyle(
                        // fontSize: 16,
                        // fontWeight: FontWeight.bold,
                        ),
                  ),
                  trailing: Text(
                    '₹ ${data?.amount ?? ""}',
                    style: const TextStyle(
                      fontSize: 16,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              sizedBoxH30(context),
              // Name
              editTextBox("Name", _nameController),

              const SizedBox(height: 15),

              // Price
              editTextBox("Price", _priceController),

              const SizedBox(height: 15),

              // Duration
              // editTextBox("Duration", _durationController),
              DropdownButtonFormField<String>(
                value: duration,
                // icon: const Icon(Icons.access_time, color: Colors.blue),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.access_time, color: Colors.blue),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                ),
                items: durations.map((value) {
                  return DropdownMenuItem(value: value, child: Text(value));
                }).toList(),
                onChanged: (newValue) => setState(() => duration = newValue),
              ),

              const SizedBox(height: 25),

              // Save Button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey,
                      foregroundColor: Colors.white,
                      elevation: 4,
                      shadowColor: Colors.black26,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                        // side: const BorderSide(color: Colors.blueAccent),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 14),
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: const Text("Cancel"),
                  ),
                  sizedBoxW30(context),
                  ElevatedButton(
                    onPressed: () async {
                      context.read<AllAmenitiesBloc>().add(EditAmenitiesEvent(
                            societyId: data?.societyId?.toString() ?? "",
                            amenityId: data?.amenityId.toString() ?? "",
                            name: _nameController.text,
                            amount: _priceController.text,
                            duration: duration ?? data?.duration ?? "",
                          ));
                      Future.delayed(Duration(seconds: 1), () {
                        context.read<AllAmenitiesBloc>().add(GetAllAmenities());
                        Future.delayed(Durations.medium4);
                        Navigator.pop(context);
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      elevation: 4,
                      shadowColor: Colors.green.shade100,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                        // side: const BorderSide(color: Colors.blueAccent),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 14),
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: const Text("Save"),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget editTextBox(String hint, TextEditingController myController) {
    bool isName = hint == "Name";
    bool isPrice = hint == "Price";

    return TextFormField(
      controller: myController,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: hint,
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.w500,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        prefixIcon: isName
            ? const Icon(Icons.person, color: Colors.orange)
            : isPrice
                ? const Icon(Icons.currency_rupee_rounded, color: Colors.green)
                : const Icon(Icons.access_time, color: Colors.blue),
      ),
    );
  }
}

/*

 // // Maintenance
    public function unpaidMaintenance(Request $request)
    {
        $request->validate([
            'society_id' => 'required|integer|exists:societies,society_id',
            'user_id' => 'required|integer|exists:users,user_id'
        ], [
            'society_id.exists' => 'The selected society does not exist.',
            'user_id.exists' => 'The selected user does not exist.',
            'society_id.required' => 'Society ID is required.',
            'user_id.required' => 'User ID is required.'
        ]);

        // $dues = Maintenance::where('society_id', $request->society_id)
        //     ->where('user_id', $request->user_id)
        //     ->get();

        // $fine = Fine::where('society_id', $request->society_id)
        //     ->where('user_id', $request->user_id)
        //     ->get();

        // if ($dues->isEmpty()) {
        //     return response()->json([
        //         'status' => 404,
        //         'message' => 'No unpaid dues found for this user in the specified society.',
        //         'data' => []
        //     ], 404);
        // }
        // return response()->json(['status' => 200, 'message' => 'Unpaid dues fetched successfully', 'maintenance' => $dues, 'fine' => $fine], 200);

        $maintenance = Maintenance::where('society_id', $request->society_id)
            ->where('user_id', $request->user_id)
            ->get();

        $fine = Fine::where('society_id', $request->society_id)
            ->where('user_id', $request->user_id)
            ->get();

        if ($maintenance->isEmpty() && $fine->isEmpty()) {
            return response()->json([
                'status' => 404,
                'message' => 'No dues or fines found for this user in the specified society.',
                'data' => []
            ], 404);
        }

        $data = [
            'society_id' => $request->society_id,
            'user_id' => $request->user_id,
            'maintenance' => $maintenance,
            'fines' => $fine,
        ];

        return response()->json([
            'status' => 200,
            'message' => 'Unpaid dues fetched successfully',
            'data' => [$data]
        ]);
    }*/
