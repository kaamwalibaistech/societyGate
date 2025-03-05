import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../../../models/admin_register_model.dart';

class AuthRepository {
  Future<AdminRegister?> registerSociety(
      String name,
      String number,
      String email,
      String societyName,
      String societyAddress,
      String totalFlat,
      String totalWings,
      String? amenities) async {
    // API key in headers directly
    final headers = {
      'API-Key': dotenv.get('API-Key'), // Ensure this is correctly loaded
      'Content-Type': 'application/x-www-form-urlencoded' // Important
    };

    Uri url = Uri.parse("https://mygate.blingbroomcleaning.com/mygetapi.php");

    final body = {
      'action': 'registration',
      'uname': name,
      'uphone': number,
      'uemail': email,
      'sname': societyName,
      'saddress': societyAddress,
      'total_flats': totalFlat,
      'total_wings': totalWings,
      'amenities': amenities ?? '' // Use an empty string if amenities is null
    };

    try {
      final response = await http.post(url, headers: headers, body: body);

      // Check if status code is 200 and if the response is valid JSON
      if (response.statusCode == 200) {
        try {
          final Map<String, dynamic> data = jsonDecode(response.body);

          if (data['status'] == '200') {
            return AdminRegister.fromJson(data);
          } else {
            // Handle non-successful status response from the API
            print('Error: ${data['message']}');
          }
        } catch (e) {
          print('Failed to parse response: $e');
          throw Exception('Failed to parse response body');
        }
      } else {
        print('Failed to register: HTTP ${response.statusCode}');
      }
    } catch (e) {
      // Log the error to understand what failed
      print('Error during request: $e');
      throw Exception('Registration failed');
    }

    return null;
  }
}
