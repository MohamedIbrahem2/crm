import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../models/note_model.dart'; // Your note model

class NoteRepository {
  final ApiServiceNote apiService;

  NoteRepository(this.apiService);

  Future<List<Note>> getNotes(String leadId) async {
    final response = await apiService.get('/notes',leadId); // Your API endpoint for fetching notes
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => Note.fromJson(e)).toList(); // Assuming you have a Note model
    } else {
      throw Exception('Failed to load notes');
    }
  }

  Future<void> addNote(Note note,String leadId) async {
    final response = await apiService.post('/notes', note.toJson(),leadId);
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to add note');
    }
  }
}
class ApiServiceNote {
  // Fetch notes from the API
  Future<http.Response> get(String endpoint,String leadId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final moduleId = prefs.getString('moduleId');  // If you need the moduleId
    final baseUrl = "https://backcrm.growcrm.tech/api/modules/$moduleId/leads/$leadId";  // Replace with your API base URL

    final url = Uri.parse('$baseUrl$endpoint'); // Combine base URL and endpoint
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final response = await http.get(url, headers: headers);
    return response;
  }

  // Add a new note via POST request
  Future<http.Response> post(String endpoint, Map<String, dynamic> body,String leadId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final moduleId = prefs.getString('moduleId');  // If you need the moduleId
    final baseUrl = "https://backcrm.growcrm.tech/api/modules/$moduleId/leads/$leadId";
    final url = Uri.parse('$baseUrl$endpoint'); // Combine base URL and endpoint
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),  // Convert body to JSON string
    );
    return response;
  }
}
