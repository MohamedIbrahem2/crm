import 'package:crm/core/networking/api_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/reminder_add_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiServiceAdd {

  Future<http.Response> post(Map<String, dynamic> body,String leadId) async {
    String baseUrl = ApiConstants.apiBaseUrl;
    final prefs = await SharedPreferences.getInstance();
    final moduleId = prefs.getString('moduleId');
    final token = prefs.getString('token');
    print(token);
    print(moduleId);
    final url = Uri.parse('$baseUrl/modules/$moduleId/leads/$leadId/reminders');
    print(url);
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );
    print(body);
    return response;
  }

// You can add more methods for GET, PUT, DELETE, etc.
}


class AddReminderRepository {
  final ApiServiceAdd apiService;

  AddReminderRepository(this.apiService);

  Future<void> addReminder(ReminderAddModel reminderData,String leadId) async {
    final response = await apiService.post(reminderData.toJson(), leadId);

    if (response.statusCode == 301 || response.statusCode == 302) {
      print("Redirecting to another URL");
      throw Exception("Redirecting to another URL: ${response.headers['location']}");
    }

    // Check for 401 Unauthorized
    if (response.statusCode == 401) {
      throw Exception('Unauthorized: Invalid API token');
    }

    // Log the response body for debugging
    print('Response body: ${response.body}');

    // Check if the request was successful
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to add reminder: ${response.reasonPhrase}');
    }
  }

}
