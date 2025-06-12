import 'dart:convert';
import 'dart:developer';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:society_gate/models/get_user_purchase_amenities_model.dart';
import 'package:society_gate/models/help_support_model.dart';
import 'package:society_gate/models/update_user_model.dart';

import '../models/add_daily_help_model.dart';
import '../models/add_family_member_model.dart';
import '../models/add_notices_model.dart';
import '../models/add_vehicle_model.dart';
import '../models/admin_register_model.dart';
import '../models/amenities_model.dart';
import '../models/announcements_model.dart';
import '../models/flat_id_model.dart';
import '../models/get_daily_help_model.dart';
import '../models/get_family_members_model.dart';
import '../models/get_vehicle_detail_model.dart';
import '../models/member_register_model.dart';
import '../models/user_approve.dart';
import '../models/watchman_add_model.dart';
import '../models/watchman_delete_model.dart';
import 'api_constant.dart';

class ApiRepository {
  String baseUrl = "https://thesocietygate.com/api/";

  Future<AdminRegister?> registerSocietyAdmin(sname, saddress, totalwings,
      totalflat, uname, uemail, uphone, flatNumber, block, floor) async {
    // Map<String, String> queryParameters = {};
    // queryParameters.addAll({"API-KEY": dotenv.get('API-KEY')});

    Uri url = Uri.parse("${baseUrl}signup");

    final body = {
      'sname': sname,
      'saddress': saddress,
      'total_wings': totalwings,
      'total_flats': totalflat,
      'amenities': "",
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
          return AdminRegister.fromJson(data);
        }
      }
      log(response.body);
    } catch (e) {
      throw Exception();
    }
    return null;
  }

  Future<Map<String, dynamic>?> amenitiesSendRawJson(
      List<Map<String, dynamic>> amenitiesList, societyId) async {
    const url = 'https://thesocietygate.com/api/amenities-for-society';

    final body = {
      "society_id": societyId,
      "amenities": amenitiesList,
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'User-Agent': 'FlutterApp/1.0',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return data;
      } else {
        log("Request failed with status: ${response.statusCode}");
        log("Body: ${response.body}");
      }
    } catch (e) {
      log("Error: $e");
    }

    return null;
  }

  Future<MemberRegisterModel?> memberRegister(
      uname, uemail, uphone, sregistrationNo, flatNumber, block, floor) async {
    final url = Uri.parse("${baseUrl}memberregister");
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

  Future<FlatIdModel?> getFlatId(societyId, flatNo, block, floor) async {
    final url = Uri.parse("${baseUrl}flatsidsearch");
    final body = {
      'society_id': societyId,
      'flat_number': flatNo,
      'block': block,
      'floor': floor,
    };
    try {
      final response = await http.post(url, body: body);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        if (data['status'] == 200) {
          return FlatIdModel.fromJson(data);
        }
        return FlatIdModel.fromJson(data);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
    return null;
  }

  Future<bool?> getExistingAmenitiesData(societyId) async {
    final url = Uri.parse("${baseUrl}check-amenity/$societyId");

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return data['exists'];
      } else {
        return null;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<UserApprove?> getUserApproval(userId) async {
    final url = Uri.parse("${baseUrl}userapprove");
    final body = {
      'user_id': userId,
    };
    try {
      final response = await http.post(url, body: body);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        if (data['status'] == 200) {
          return UserApprove.fromJson(data);
        }
        return UserApprove.fromJson(data);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
    return null;
  }

  Future<Announcementmodel?> getHomePageData(societyId) async {
    final url = Uri.parse("${baseUrl}getannouncement");
    final body = {
      'society_id': societyId,
    };
    try {
      final response = await http.post(url, body: body);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        if (data['status'] == 200) {
          return Announcementmodel.fromJson(data);
        }
        return Announcementmodel.fromJson(data);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
    return null;
  }

  Future<int?> communityPost(
      societyId, adminId, title, description, photo) async {
    final url = Uri.parse("${baseUrl}communitypostinsert");
    final body = {
      'society_id': societyId,
      'admin_id': adminId,
      'title': title,
      'description': description,
      'photo': photo,
    };
    try {
      final response = await http.post(url, body: body);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        return data['status'];
      }
    } catch (e) {
      throw Exception(e.toString());
    }
    return null;
  }

// <<<<<<< anil
//   Future<AddFamilyMemberModel?> addFamilyMembers(societyid, flatid, memberid,
//       uname, uemail, uphone, relation, password) async {
//     final url = Uri.parse("${baseUrl}familymembersadd");
// // =======
  Future<AddFamilyMemberModel?> addFamilyMembers(
    societyid,
    flatid,
    memberid,
    uname,
    uemail,
    uphone,
    relation,
  ) async {
    final url = Uri.parse("https://thesocietygate.com/api/familymembersadd");
// >>>>>>> final
    final body = {
      'society_id': societyid,
      'flat_id': flatid,
      'member_id': memberid,
      'uname': uname,
      'uemail': uemail,
      'uphone': uphone,
      'relation': relation,
      // 'password': password,
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
    final url = Uri.parse("${baseUrl}familymembersget");
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

  Future<GetUserPurchaseAmenitiesModel?> getFamilyMemGetUserPurchaseAmenities(
      societyId, userId) async {
    final url = Uri.parse("${baseUrl}getamenitiesbyuser");
    final body = {
      'society_id': societyId,
      'user_id': userId,
    };
    try {
      final response = await http.post(url, body: body);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        if (data['status'] == 200) {
          return GetUserPurchaseAmenitiesModel.fromJson(data);
        }
        return GetUserPurchaseAmenitiesModel.fromJson(data);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
    return null;
  }

  Future<GetVehicleDetailsModel?> getVehicleDetails(flatid) async {
    final url = Uri.parse("${baseUrl}getvehicleparking");
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

  Future<UpdateUserModel?> updateUser(userId, name, email, number) async {
    final url = Uri.parse("${baseUrl}userupdate");
    final body = {
      'user_id': userId,
      'uname': name,
      'uemail': email,
      'uphone': number,
    };
    try {
      final response = await http.post(url, body: body);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        if (data['status'] == 200) {
          return UpdateUserModel.fromJson(data);
        } else {
          return UpdateUserModel.fromJson(data);
        }
      }
    } catch (e) {
      log(e.toString());
      throw Exception(e.toString());
    }
    return null;
  }

  Future<HelpSupportModel?> postSupportMessage(
      societyId, userId, title, message) async {
    final url = Uri.parse("${baseUrl}supportinsert");
    final body = {
      'society_id': societyId,
      'user_id': userId,
      'title': title,
      'message': message,
    };
    try {
      final response = await http.post(url, body: body);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        if (data['status'] == 200) {
          return HelpSupportModel.fromJson(data);
        }
        return HelpSupportModel.fromJson(data);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
    return null;
  }

  Future<AddDailyHelpModel?> addDailyHelpMembers(
      societyid, memberid, flatid, name, phone, address, emptype) async {
    final url = Uri.parse("${baseUrl}employmentadd");
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
        return null;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
    return null;
  }

  Future<WatchManAddModel?> addWatchman(
      societyid, name, email, phoneNo, password) async {
    final url = Uri.parse("${baseUrl}watchmenadd");
    final body = {
      'society_id': societyid,
      'uname': name,
      'uemail': email,
      'uphone': phoneNo,
      'upassword': password,
    };
    try {
      final response = await http.post(url, body: body);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        if (data['status'] == 200) {
          return WatchManAddModel.fromJson(data);
        }
        return WatchManAddModel.fromJson(data);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
    return null;
  }

  Future<GetDailyHelpModel?> getDailyHelpMembers(societyid, flatid) async {
    final url = Uri.parse("${baseUrl}employmentget");
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
        return null;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
    return null;
  }

  Future<WatchManDeleteModel?> deleteWatchman(userId) async {
    final url = Uri.parse("${baseUrl}watchmendelete");
    final body = {
      'user_id': userId,
    };
    try {
      final response = await http.post(url, body: body);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        if (data['status'] == 200) {
          return WatchManDeleteModel.fromJson(data);
        }
        return WatchManDeleteModel.fromJson(data);
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
    final url = Uri.parse("${baseUrl}insertvehicleparking");
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
    final url = Uri.parse("${baseUrl}announcementsadd");
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

  Future<AmenitiesModel?> fetchAmenities(societyid) async {
    final url = Uri.parse("${baseUrl}get-amenities-by-societyid");
    final body = {
      'society_id': societyid.toString(),
    };
    try {
      final response = await http.post(url, body: body);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        log("Api DATA: ${data.toString()}");
        return AmenitiesModel.fromJson(data);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
    return null;
  }

  Future<String?> bookAmenities(Map<String, String> amenitiesMap) async {
    final url = Uri.parse("${baseUrl}book-amenities");
    final body = {};
    try {
      final response = await http.post(url, body: body);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return data['message'];
      }
    } catch (e) {
      throw Exception(e.toString());
    }
    return null;
  }
}
