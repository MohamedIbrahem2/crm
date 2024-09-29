import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class StatusRepository {
  Future<Map<String, int>> fetchStatusCounts() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final moduleId = prefs.getString('moduleId');
    final response = await http.get(
      Uri.parse('https://backcrm.growcrm.tech/api/modules/$moduleId/dashboard-summary'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      if (data.containsKey('converted_customers') &&
          data.containsKey('leads_in_processing') &&
          data.containsKey('lost_leads')) {

        return {
          'converted_customers': data['converted_customers'],
          'leads_in_processing': data['leads_in_processing'],
          'lost_leads': data['lost_leads'],
        };
      } else {
        throw Exception('Data key is missing or null in the response.');
      }
    } else {
      throw Exception('Failed to load status counts: ${response.statusCode}');
    }
  }
}
