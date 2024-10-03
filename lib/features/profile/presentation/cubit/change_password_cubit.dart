import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
// Define the possible states for the change password functionality
part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit() : super(ChangePasswordInitial());

  Future<void> changePassword(String password,String confirmPass) async {
    emit(ChangePasswordLoading()); // Start the loading state

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token");

      final response = await http.post(
        Uri.parse('https://backcrm.growcrm.tech/api/profile/update'), // Change this to the correct API endpoint
        body: {
          'password': password,
          'password_confirmation': confirmPass,
        },
        headers: {
          'Authorization': 'Bearer $token',
          'Accept' : 'application/json',
        },
      );
      print(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(ChangePasswordSuccess('Password changed successfully.'));
      } else {
        emit(ChangePasswordFailure('Failed to change password. Please try again.'));
      }
    } catch (e) {
      emit(ChangePasswordFailure('Error: $e'));
    }
  }
}
