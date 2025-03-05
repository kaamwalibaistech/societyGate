import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/admin_register_model.dart';

class ApiRepository {
  Future<dynamic> registerSociety(sname, saddress, totalwings, totalflat,
      amenities, uname, uemail, uphone) async {
    // Map<String, String> queryParameters = {};
    // queryParameters.addAll({"API-KEY": dotenv.get('API-KEY')});

    Uri url = Uri.parse("https://blingbroomcleaning.com/api/signup");

    final body = {
      'sname': sname,
      'saddress': saddress,
      'total_wings': totalwings,
      'total_flats': totalflat,
      'amenities': amenities ?? "",
      'uname': uname,
      'uemail': uemail,
      'uphone': uphone
    };
    try {
      final response = await http.post(url, body: body);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        if (data['status'] == 200) {
          return AdminRegister.fromJson(data);
        }
      } else {
        final Map<String, dynamic> data = jsonDecode(response.body);
        print(data["message"]);
        return (data["message"]);
      }
    } catch (e) {
      throw Exception();
    }
    return null;
  }
}
