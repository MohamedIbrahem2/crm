import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/leads_model.dart';

class LeadsRepository {
  Future<List<Lead>> getLeads() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final moduleId = prefs.getString('moduleId');
    try {
      final response = await http.get(
        Uri.parse('https://backcrm.growcrm.tech/api/modules/$moduleId/leads'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        if (jsonResponse['status'] == 'success' &&
            jsonResponse['data'] is Map<String, dynamic> &&
            jsonResponse['data']['data'] is List) {

          final List<dynamic> leadsData = jsonResponse['data']['data'];
          return leadsData.map((leadJson) => Lead.fromJson(leadJson)).toList();
        } else {
          print('No leads available or unexpected response structure.');
          return [
          ];
        }
      } else {

        print('Failed to fetch leads. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        return [];
      }
    } catch (e) {

      print('Error while fetching leads: $e');
      throw Exception('Error fetching leads');
    }
  }

}
