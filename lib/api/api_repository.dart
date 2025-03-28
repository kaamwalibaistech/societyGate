import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:my_society/models/member_register_model.dart';

import '../models/add_daily_help_model.dart';
import '../models/add_family_member_model.dart';
import '../models/add_notices_model.dart';
import '../models/add_vehicle_model.dart';
import '../models/admin_register_model.dart';
import '../models/get_daily_help_model.dart';
import '../models/get_family_members_model.dart';
import '../models/get_vehicle_detail_model.dart';
import '../models/homepage_model.dart';
import 'api_constant.dart';

class ApiRepository {
  Future<AdminRegister?> registerSocietyAdmin(
      sname,
      saddress,
      totalwings,
      totalflat,
      amenities,
      uname,
      uemail,
      uphone,
      flatNumber,
      block,
      floor) async {
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
      'uphone': uphone,
      "flat_number": flatNumber,
      "block": block,
      "floor": floor,
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
      uname, uemail, uphone, sregistrationNo, flatNumber, block, floor) async {
    final url = Uri.parse("https://blingbroomcleaning.com/api/memberregister");
    final body = {
      'uname': uname,
      'uemail': uemail,
      'uphone': uphone,
      'sregistration_no': sregistrationNo,
      'flat_number': flatNumber,
      'block': block,
      'floor': floor,
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

  Future<Homepagemodel?> getHomePageData(societyId) async {
    final url = Uri.parse("https://blingbroomcleaning.com/api/homepage");
    final body = {
      'society_id': societyId,
    };
    try {
      final response = await http.post(url, body: body);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        if (data['status'] == 200) {
          return Homepagemodel.fromJson(data);
        }
        return Homepagemodel.fromJson(data);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
    return null;
  }

  Future<AddFamilyMemberModel?> addFamilyMembers(societyid, flatid, memberid,
      uname, uemail, uphone, relation, password) async {
    final url =
        Uri.parse("https://blingbroomcleaning.com/api/familymembersadd");
    final body = {
      'society_id': societyid,
      'flat_id': flatid,
      'member_id': memberid,
      'uname': uname,
      'uemail': uemail,
      'uphone': uphone,
      'relation': relation,
      'password': password,
    };
    try {
      final response = await http.post(url, body: body);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        if (data['status'] == 200) {
          return AddFamilyMemberModel.fromJson(data);
        }
        return AddFamilyMemberModel.fromJson(data);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
    return null;
  }

  Future<GetFamilyMemberModel?> getFamilyMembers(flatid) async {
    final url =
        Uri.parse("https://blingbroomcleaning.com/api/familymembersget");
    final body = {
      'flat_id': flatid,
    };
    try {
      final response = await http.post(url, body: body);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        if (data['status'] == 200) {
          return GetFamilyMemberModel.fromJson(data);
        }
        return GetFamilyMemberModel.fromJson(data);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
    return null;
  }

  Future<GetVehicleDetailsModel?> getVehicleDetails(flatid) async {
    final url =
        Uri.parse("https://blingbroomcleaning.com/api/getvehicleparking");
    final body = {
      'flat_id': flatid,
    };
    try {
      final response = await http.post(url, body: body);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        if (data['status'] == 200) {
          return GetVehicleDetailsModel.fromJson(data);
        }
        return GetVehicleDetailsModel.fromJson(data);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
    return null;
  }

  Future<AddDailyHelpModel?> addDailyHelpMembers(
      societyid, memberid, flatid, name, phone, address, emptype) async {
    final url = Uri.parse("https://blingbroomcleaning.com/api/employmentadd");
    final body = {
      'society_id': societyid,
      'member_id': memberid,
      'flat_id': flatid,
      'name': name,
      'phone': phone,
      'address': address,
      'emp_type': emptype,
    };
    try {
      final response = await http.post(url, body: body);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        if (data['status'] == 200) {
          return AddDailyHelpModel.fromJson(data);
        }
        return AddDailyHelpModel.fromJson(data);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
    return null;
  }

  Future<GetDailyHelpModel?> getDailyHelpMembers(societyid, flatid) async {
    final url = Uri.parse("https://blingbroomcleaning.com/api/employmentget");
    final body = {
      'society_id': societyid,
      'flat_id': flatid,
    };
    try {
      final response = await http.post(url, body: body);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        if (data['status'] == 200) {
          return GetDailyHelpModel.fromJson(data);
        }
      }
    } catch (e) {
      throw Exception(e.toString());
    }
    return null;
  }

  Future<AddVehicleModel?> addVehicle(
    societyid,
    memberId,
    flatid,
    vehicleNo,
    type,
    model,
    String? slotNumber,
  ) async {
    final url =
        Uri.parse("https://blingbroomcleaning.com/api/insertvehicleparking");
    final body = {
      'society_id': societyid,
      "member_id": memberId,
      'flat_id': flatid,
      "vehicle_no": vehicleNo,
      "type": type,
      "model": model,
      "status": "active",
      "slot_number": slotNumber ?? "",
      "parking_status": "occupied"
    };
    try {
      final response = await http.post(url, body: body);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        if (data['status'] == 200) {
          return AddVehicleModel.fromJson(data);
        }
        return AddVehicleModel.fromJson(data);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
    return null;
  }

  Future<void> manualAproveApi(
    String uniqueCode,
    String watchmanId,
    String action,
  ) async {
    String api = ApiConstant.aproveVisitor;
    String baseUrl = ApiConstant.baseUrl;
    Uri url = Uri.parse(baseUrl + api);

    final body = {
      'unique_code': uniqueCode,
      'watchman_id': watchmanId,
      'action': action,
    };
    try {
      final response = await http.post(url, body: body);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        Fluttertoast.showToast(msg: data['message']);

        if (data['status'] == 200) {
          //await Future.delayed(const Duration(milliseconds: 300));
          //  successDialog();
        } else {
          // await Future.delayed(const Duration(milliseconds: 300));
          //failedDialog(data['message']);
        }
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error occurred: $e");
      // Navigator.pop(context);
    }
  }

  Future<AddNoticeModel?> addNotices(societyid, memberId, String title,
      String description, String announcementType) async {
    final url =
        Uri.parse("https://blingbroomcleaning.com/api/announcementsadd");
    final body = {
      'society_id': societyid,
      "user_id": memberId,
      'title': title,
      "description": description,
      "announcement_type": announcementType,
    };
    try {
      final response = await http.post(url, body: body);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        if (data['status'] == 200) {
          return AddNoticeModel.fromJson(data);
        }
        return AddNoticeModel.fromJson(data);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
    return null;
  }
}
