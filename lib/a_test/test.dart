// import 'dart:convert';

// void main() {
//   print("\n");
//   List<Map<String, String>> car = [
//     {"Name": "Volvo", "Price": "2000", "Model": "new"},
//     {"Name": "BMW", "Price": "5000", "Model": "old"},
//     {"Name": "Suzuki", "Price": "8000", "Model": "new"},
//     {"Name": "Ford", "Price": "9000", "Model": "old"},
//     {"Name": "Tesla", "Price": "2300", "Model": "ne+]]w"},
//   ];
//   String planText = jsonEncode(car);
//   // print(planText);

//   final carModel = CarModel.fromJson(jsonDecode(planText));

//   print(carModel);

//   // print("Cart List:\n ${car}");

//   // var scar = car.firstWhere((e) => e['Name'] == "BMW", orElse: () => {});

//   // print(scar);

//   // car.removeWhere((e) => e['Name'] == "BMW");

//   // car.add({"Name": "BMW", "Price": "5000", "Model": "old"});

//   // print("Cart List:\n ${car}");

//   // print(scar['Name']);
//   // print(car.elementAt(0));

//   // print(car);

//   // for (var c in car) {
//   //   // print("${c['Name']}: ${c['Price']}: ${c['Model']}");
//   // }

//   // final index = car.indexWhere((e) => e["Name"] == "BMW");

//   // if (index != -1) {
//   //   car[index]["Price"] = "9999";
//   // }

//   // print(car);

//   var filtered = car.where((element) => element['Model'] == "new").toList();

//   print(filtered);

//   print('\n');
// }

// class CarModel {
//   String? name;
//   String? price;
//   String? model;

//   CarModel({required this.name, required this.price, required this.model});

//   factory CarModel.fromJson(Map<String, String> json) =>
//       CarModel(name: json['Name'], price: json['Price'], model: json['Model']);

//   Map<String, String> toJson() => {
//         "Name": name ?? "",
//         "Price": price ?? '',
//         "Model": model ?? '',
//       };
// }

void main() {
  List<int> intList = [];
  List<String> stringList = [];

  // List<Maintainance>

  List<Combine> newList = [];

  newList.addAll([Combine(listdata: intList)]);
  newList.addAll([Combine(listdata: stringList)]);

  print(newList.first.listdata);
}

class Combine {
  final dynamic listdata;

  Combine({required this.listdata});
}

// void main() {
//   List<int> intList = [1, 2, 3, 4, 5];
//   List<String> stringList = ["a", "b", "c"];

//   List<dynamic> newList = [];
//   newList.addAll([intList]);
//   newList.addAll([stringList]);
//   print(newList);
// }
