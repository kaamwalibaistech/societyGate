import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_society/models/member_register_model.dart';

import '../models/admin_register_model.dart';

class ApiRepository {
  Future<AdminRegister?> registerSocietyAdmin(sname, saddress, totalwings,
      totalflat, amenities, uname, uemail, uphone) async {
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
        } else {
          final Map<String, dynamic> data = jsonDecode(response.body);

          return AdminRegister.fromJson(data);
        }
      }
    } catch (e) {
      throw Exception();
    }
    return null;
  }

  Future<MemberRegisterModel?> memberRegister(
      uname, uemail, uphone, sregistrationNo) async {
    final url = Uri.parse("https://blingbroomcleaning.com/api/memberregister");
    final body = {
      'uname': uname,
      'uemail': uemail,
      'uphone': uphone,
      'sregistration_no': sregistrationNo
    };
    try {
      final response = await http.post(url, body: body);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        if (data['status'] == 200) {
          return MemberRegisterModel.fromJson(data);
        }
        return MemberRegisterModel.fromJson(data);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
    return null;
  }
}
