import 'dart:convert';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class FileUploadState {
  final File? file;
  final String? successMessage;
  final String? errorMessage;
  final bool isUploading;
  final List<dynamic>? proposals; // To hold the fetched proposals

  FileUploadState( {this.file, this.errorMessage,this.successMessage, this.isUploading = false, this.proposals});

  FileUploadState copyWith({
    File? file,
    String? successMessage,
    String? errorMessage,
    bool? isUploading,
    List<dynamic>? proposals,
  }) {
    return FileUploadState(
      successMessage: successMessage,
      file: file ?? this.file,
      errorMessage: errorMessage,
      isUploading: isUploading ?? this.isUploading,
      proposals: proposals ?? this.proposals,
    );
  }
}


class FileUploadCubit extends Cubit<FileUploadState> {
  final String leadsId;
  FileUploadCubit(this.leadsId) : super(FileUploadState());

  void selectFile(File selectedFile) {
    if (selectedFile.lengthSync() <= 10 * 1024 * 1024) {
      emit(state.copyWith(file: selectedFile, errorMessage: null));
    } else {
      emit(state.copyWith(errorMessage: "File size should not exceed 10 MB."));
    }
  }

  Future<void> uploadFileProposal() async {
    if (state.file != null) {

      emit(state.copyWith(isUploading: true, errorMessage: null));
      try {
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString("token");
        final moduleId = prefs.getString('moduleId');

        var request = http.MultipartRequest(
          'POST',
          Uri.parse('https://backcrm.growcrm.tech/api/modules/$moduleId/leads/$leadsId/proposals'),
        );

        request.headers.addAll({
          'Authorization': 'Bearer $token',
          "Content-Type": "multipart/form-data",// Replace with your token
        });

        // Add the file to the request
        request.files.add(await http.MultipartFile.fromPath(
          'file', // Key for the file parameter in your API
          state.file!.path,
        ));
        request.fields['description'] = 'File upload'; // Ensure this field is correct

        var response = await request.send();

        if (response.statusCode == 200) {
          print("----------------");
          final responseBody = await response.stream.bytesToString();
          emit(state.copyWith(isUploading: false));
          print("Upload successful: $responseBody");
        } else {
          final responseBody = await response.stream.bytesToString();
          print("Upload failed: ${response.statusCode}, ${response.reasonPhrase}, $responseBody");
          emit(state.copyWith(errorMessage: "Upload failed: ${response.reasonPhrase}\n$responseBody"));
        }
      } catch (e) {
        emit(state.copyWith(errorMessage: "Upload failed: $e", isUploading: false));
        print("Error during file upload: $e");
      }
    } else {
      emit(state.copyWith(errorMessage: "No file selected."));
    }
  }


  // Function to fetch proposals from the API
  Future<void> fetchProposals() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    try {
      final response = await http.get(
        Uri.parse('https://backcrm.growcrm.tech/api/modules/1/leads/$leadsId/proposals'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        // Decode the JSON response directly to a List<dynamic>
        final List<dynamic> proposals = jsonDecode(response.body);

        emit(state.copyWith(proposals: proposals));  // Update state with the fetched proposals
      } else {
        emit(state.copyWith(errorMessage: 'Failed to fetch proposals.'));
      }
    } catch (e) {
      emit(state.copyWith(errorMessage: 'Error fetching proposals: $e'));
    }
  }
  Future<void> deleteImageProposal(int proposalId) async {
    final prefs = await SharedPreferences.getInstance();
    final moduleId = prefs.getString('moduleId');
    final token = prefs.getString('token');
    try {
      final response = await http.delete(
        Uri.parse('http://back.growcrm.tech/api/modules/$moduleId/leads/$leadsId/proposals/$proposalId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      print(proposalId);
      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');
      if (response.statusCode == 200) {
        emit(state.copyWith(
          proposals: state.proposals?.where((p) => p['id'] != proposalId).toList(),
          errorMessage: null,
        ));      } else {
        emit(state.copyWith(errorMessage: 'Failed to delete image'));
      }
    } catch (e) {
      emit(state.copyWith(errorMessage: 'Error deleting image: $e'));
    }
  }
}

