import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AssignedUsersRepository {
  Future<List<int>> getAssignedUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      throw Exception('Token is missing');
    }

    final url = Uri.parse('https://backcrm.growcrm.tech/api/users/assigned'); // Update with the correct endpoint for assigned users
    final headers = {
      'Authorization': 'Bearer $token',
    };

    final response = await http.get(url, headers: headers);

    // Check for redirect status codes
    if (response.statusCode == 301 || response.statusCode == 302) {
      throw Exception("Redirecting to another URL: ${response.headers['location']}");
    }

    // Check for 401 Unauthorized
    if (response.statusCode == 401) {
      throw Exception('Unauthorized: Invalid API token');
    }

    // Check if the request was successful
    if (response.statusCode != 200) {
      throw Exception('Failed to fetch assigned users: ${response.reasonPhrase}');
    }

    // Parse the response body to extract user data
    final List<dynamic> data = jsonDecode(response.body)['data'];
    return data.map((user) => user['id'] as int).toList(); // Assuming each user has an 'id' field
  }
}
