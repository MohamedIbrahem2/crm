import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/leads_model.dart';

class LeadsRepository {
  Future<List<Lead>> getLeads() async {
    try {
      final response = await http.get(
        Uri.parse('https://back.growcrm.tech/api/modules/1/leads'),
        headers: {
          'Authorization': 'Bearer 193|QHc2wRxqUlPGeTLWcPb4sWJPwGW8oPzE6Qc0htXN287bd381',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);

        // Access the leads using the correct path
        if (jsonResponse['status'] == 'success' &&
            jsonResponse['data'] is Map<String, dynamic> &&
            jsonResponse['data']['data'] is List) {

          final List<dynamic> leadsData = jsonResponse['data']['data'];
          return leadsData.map((leadJson) => Lead.fromJson(leadJson)).toList();
        } else {
          print('No leads available or unexpected response structure.');
          return [];
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
