import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:society_gate/amenities/amenities_images.dart';

class EditAmenities extends StatefulWidget {
  const EditAmenities({super.key});

  @override
  State<EditAmenities> createState() => _EditAmenitiesState();
}

class _EditAmenitiesState extends State<EditAmenities> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  bool _isExpanded = false;

  void _toggleCard() {
    setState(() {
      _isExpanded = !_isExpanded;
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
        child: Column(
          children: [
            SizedBox(
              width: double.maxFinite,
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
            GestureDetector(
              onTap: _toggleCard,
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
                          getAmenityImage("gym"),
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        " widget.amenityName",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: Icon(
                        _isExpanded
                            ? Icons.keyboard_arrow_up_rounded
                            : Icons.keyboard_arrow_down_rounded,
                      ),
                    ),
                    if (_isExpanded)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton.icon(
                              onPressed: () {
                                // Handle edit
                              },
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              label: const Text("Edit",
                                  style: TextStyle(color: Colors.blue)),
                            ),
                            const SizedBox(width: 10),
                            TextButton.icon(
                              onPressed: showDeleteConfirmation,
                              icon: const Icon(Icons.delete, color: Colors.red),
                              label: const Text("Delete",
                                  style: TextStyle(color: Colors.red)),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showDeleteConfirmation() {
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
            onPressed: () {
              // Delete logic here
              Navigator.pop(context);
            },
            child: const Text("Delete"),
          ),
        ],
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
