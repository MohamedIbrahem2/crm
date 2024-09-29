import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class AddLeadsRepository {
  Future<ApiResponse> addLead({
    required String name,
    required String phone,
    required String email,
    required String company,
    required String city,
    required String address,
    required String needs,
    required int leadValue,
    required String position,
    required String state,
    required int countryId,
    required String website,
    required String zipCode,
    required int sourceId,
    required int statusId,
    required int assignedTo,
    required int productRelatedId,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final moduleId = prefs.getString('moduleId');
    final url = Uri.parse('https://backcrm.growcrm.tech/api/modules/$moduleId/product-type/2/leads');
    final body = jsonEncode({
      'name': name,
      'phone': phone,
      'email': email,
      'company': company,
      'city': city,
      'address': address,
      'needs': needs,
      'lead_value': leadValue,
      'position': position,
      'state': state,
      'country_id': countryId,
      'website': website,
      'zip_code': zipCode,
      'source_id': sourceId,
      'status_id': statusId,
      'assigned_to': assignedTo,
      'product_related_id': productRelatedId,
    });

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token', // Use a valid token
          'Content-Type': 'application/json',
        },
        body: body,
      );

      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ApiResponse.success();
      } else {
        return ApiResponse.failure(message: 'Failed to add lead: ${response.body}');
      }
    } catch (e) {
      return ApiResponse.failure(message: 'Failed to add lead: ${e.toString()}');
    }
  }
}


class ApiResponse {
  final bool isSuccess;
  final String? message;

  ApiResponse.success() : isSuccess = true, message = null;
  ApiResponse.failure({required this.message}) : isSuccess = false;
}
