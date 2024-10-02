import 'package:bloc/bloc.dart';
import 'package:crm/core/networking/api_constants.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/model/profile model.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial()){
    fetchProfileData();
  }

  Future<void> fetchProfileData() async {
    emit(ProfileLoading());
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      // Make sure the token exists
      if (token == null) {
        emit(ProfileError('No token found'));
        return;
      }

      final response = await http.get(
          Uri.parse('${ApiConstants.apiBaseUrl}/me'),
          headers: {
            'Authorization': 'Bearer $token',
          }
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        if (jsonResponse.containsKey('data')) {
          final Map<String, dynamic> data = jsonResponse['data'];

          Profile profile = Profile.fromJson(data);

          emit(ProfileLoaded(profile));
        } else {
          emit(ProfileError('Data field is missing in the response'));
        }
      } else {
        emit(ProfileError('Failed to load profile data: ${response.statusCode}'));
      }
    } catch (e) {
      print('Error fetching profile data: $e'); // Debugging
      emit(ProfileError('An error occurred while fetching profile data.'));
    }
  }


  Future<void> uploadProfileImage(String imagePath) async {
    print(imagePath);
    emit(ProfileLoading());
    print('Upload function triggered.'); // Debug start

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      print('Token retrieved: $token'); // Debug token check

      // Checking the token's existence before proceeding
      if (token == null) {
        print('No token found'); // If the token is null
        emit(ProfileError('Authorization token not found'));
        return;
      }

      final request = http.MultipartRequest(
        'POST',
        Uri.parse('${ApiConstants.apiBaseUrl}/users/register'), // Your API URL
      );

      // Debugging the URL and headers
      print('Request URL: ${ApiConstants.apiBaseUrl}/users/register');
      print('Setting up request headers');
      print(token);

      request.headers.addAll({
        'Authorization': 'Bearer $token',
        "Content-Type": "multipart/form-data",
      });

      print('Headers added: ${request.headers}'); // Debug headers

      // Check if the file path is valid
      print('Image path: $imagePath');
      try {
        request.files.add(await http.MultipartFile.fromPath('photo', imagePath));
        print('File added to request');
      } catch (e) {
        print('Error adding file: $e'); // Debug file error
        emit(ProfileError('Error adding file: $e'));
        return;
      }

      print('Sending request...');
      final response = await request.send();

      print('Response status code: ${response.statusCode}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Image uploaded successfully'); // Success debug message
        emit(ProfileSuccess('Profile image uploaded successfully'));
      } else {
        // Log the response body for detailed debugging
        final responseBody = await response.stream.bytesToString();
        print('Failed to upload image: ${response.statusCode}, body: $responseBody');
        emit(ProfileError('Failed to upload image: ${response.statusCode}'));
      }
    } catch (e) {
      // Catch and log any unexpected errors
      print('Error uploading profile image: $e'); // Debug catch
      emit(ProfileError('An error occurred while uploading the image.'));
    }
  }

}
