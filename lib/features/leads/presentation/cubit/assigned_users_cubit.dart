import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../data/models/assigned_users_model.dart';
// Define states
abstract class AssignedUsersState extends Equatable {
  const AssignedUsersState();

  @override
  List<Object> get props => [];
}

class AssignedUsersInitial extends AssignedUsersState {}

class AssignedUsersLoading extends AssignedUsersState {}

class AssignedUsersLoaded extends AssignedUsersState {
  final List<AssignedUser> assignedUsers;

  AssignedUsersLoaded(this.assignedUsers);

  @override
  List<Object> get props => [assignedUsers];
}

class AssignedUsersError extends AssignedUsersState {
  final String message;

  AssignedUsersError(this.message);

  @override
  List<Object> get props => [message];
}

// Cubit
class AssignedUsersCubit extends Cubit<AssignedUsersState> {
  AssignedUsersCubit() : super(AssignedUsersInitial());

  Future<void> fetchAssignedUsers() async {
    emit(AssignedUsersLoading());
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final response = await http.get(Uri.parse('https://backcrm.growcrm.tech/api/users/assgined'),headers:
          {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          }
      );
      print(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<dynamic> jsonData = json.decode(response.body);

        final List<AssignedUser> users = jsonData
            .map((userJson) => AssignedUser.fromJson(userJson))
            .toList();

        emit(AssignedUsersLoaded(users));
      } else {
        emit(AssignedUsersError('Failed to load users'));
      }
    } catch (e) {
      emit(AssignedUsersError('An error occurred: $e'));
    }
  }
}
