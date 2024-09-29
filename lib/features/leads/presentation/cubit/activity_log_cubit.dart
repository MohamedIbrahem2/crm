import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/models/activity_log_model.dart';

class ApiServiceLog {
  final String baseUrl = 'https://backcrm.growcrm.tech';
  Future<List<dynamic>> fetchActivityLogs(String leadId) async {
    final prefs = await SharedPreferences.getInstance();
    final moduleId = prefs.getString("moduleId");
    final token = prefs.getString("token");
    final url = Uri.parse('$baseUrl/api/modules/$moduleId/leads/$leadId/activity-logs',
    );
    final response = await http.get(url,headers: {
      'Authorization': 'Bearer $token', // Use a valid token
      'Content-Type': 'application/json',
    });

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['list']; // Return the list of activities
    } else {
      throw Exception('Failed to load activity logs');
    }
  }
}
// States
class ActivityLogState extends Equatable {
  @override
  List<Object> get props => [];
}

class ActivityLogInitial extends ActivityLogState {}

class ActivityLogLoading extends ActivityLogState {}

class ActivityLogLoaded extends ActivityLogState {
  final List<ActivityLog> logs;

  ActivityLogLoaded(this.logs);

  @override
  List<Object> get props => [logs];
}

class ActivityLogError extends ActivityLogState {
  final String message;

  ActivityLogError(this.message);

  @override
  List<Object> get props => [message];
}

// Cubit
class ActivityLogCubit extends Cubit<ActivityLogState> {
  final ApiServiceLog apiService;

  ActivityLogCubit(this.apiService) : super(ActivityLogInitial());

  Future<void> fetchActivityLogs(String customerId) async {
    try {
      emit(ActivityLogLoading());
      final logs = await apiService.fetchActivityLogs(customerId);
      emit(ActivityLogLoaded(logs.map((log) => ActivityLog.fromJson(log)).toList()));
    } catch (e) {
      emit(ActivityLogError('Failed to load activity logs'));
    }
  }
}
