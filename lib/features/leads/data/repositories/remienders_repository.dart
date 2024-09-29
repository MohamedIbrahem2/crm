

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/leads_model.dart';
import '../models/remienders_model.dart';


class ReminderRepository {
  final ApiService apiService;

  ReminderRepository(this.apiService);

  Future<List<ReminderModel>> getReminders(String token,String leadId) async {
    final response = await apiService.get('reminders', token,leadId);
    return (response.data['data'] as List)
        .map((json) => ReminderModel.fromJson(json))
        .toList();
  }
}




class ApiService {
  final Dio dio = Dio();

  Future<Response> get(String path, String token,String leadId) async {
    final prefs = await SharedPreferences.getInstance();
    final moduleId = prefs.getString('moduleId');
    final token = prefs.getString('token');
    return await dio.get('https://backcrm.growcrm.tech/api/modules/$moduleId/leads/$leadId/$path',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );
  }
}

