import 'dart:convert';
import 'package:http/http.dart' as http;

class StatusRepository {
  Future<List<String>> fetchStatusNames() async {
    final response = await http.get(
      Uri.parse('http://back.growcrm.tech/api/modules/1/lead-statuses/get'),
      headers: {
        'Authorization': 'Bearer 193|QHc2wRxqUlPGeTLWcPb4sWJPwGW8oPzE6Qc0htXN287bd381',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<dynamic> statuses = data['data']; // Access the 'data' list

      // Map the list to get the status names
      return List<String>.from(statuses.map((item) => item['status_name'] as String));
    } else {
      throw Exception('Failed to load status names: ${response.statusCode}');
    }
  }
}
