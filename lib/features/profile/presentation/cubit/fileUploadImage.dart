import 'dart:convert';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class FileUploadImageState {
  final File? file;
  final String? successMessage;
  final String? errorMessage;
  final bool isUploading;
  final List<dynamic>? proposals; // To hold the fetched proposals

  FileUploadImageState( {this.file, this.errorMessage,this.successMessage, this.isUploading = false, this.proposals});

  FileUploadImageState copyWith({
    File? file,
    String? successMessage,
    String? errorMessage,
    bool? isUploading,
    List<dynamic>? proposals,
  }) {
    return FileUploadImageState(
      successMessage: successMessage,
      file: file ?? this.file,
      errorMessage: errorMessage,
      isUploading: isUploading ?? this.isUploading,
      proposals: proposals ?? this.proposals,
    );
  }
}


class FileUploadImageCubit extends Cubit<FileUploadImageState> {
  FileUploadImageCubit() : super(FileUploadImageState());

  void selectImageFile(File selectedFile) {
    if (selectedFile.lengthSync() <= 10 * 1024 * 1024) {
      emit(state.copyWith(file: selectedFile, errorMessage: null));
      uploadFileProposalImage();
    } else {
      emit(state.copyWith(errorMessage: "File size should not exceed 10 MB."));
    }
  }

  Future<void> uploadFileProposalImage() async {
    if (state.file != null) {
      emit(state.copyWith(isUploading: true, errorMessage: null));
      try {
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString("token");

        var request = http.MultipartRequest(
          'POST',
          Uri.parse('https://backcrm.growcrm.tech/api/profile/update'),
        );

        request.headers.addAll({
          'Authorization': 'Bearer $token',
          "Content-Type": "multipart/form-data",
        });

        // Add the file to the request
        request.files.add(await http.MultipartFile.fromPath(
          'photo', // Key for the file parameter in your API
          state.file!.path,
        ));

        request.fields['description'] = 'File upload'; // Ensure this field is correct

        var response = await request.send();

        // Read the response stream once and store it
        final responseBody = await response.stream.bytesToString();

        if (response.statusCode == 200 || response.statusCode == 201) {
          print("----------------");
          print("Upload successful: $responseBody");
          emit(state.copyWith(isUploading: false));
        } else {
          print("Upload failed: ${response.statusCode}, ${response.reasonPhrase}, $responseBody");
          emit(state.copyWith(
            errorMessage: "Upload failed: ${response.reasonPhrase}\n$responseBody",
          ));
        }
      } catch (e) {
        emit(state.copyWith(errorMessage: "Upload failed: $e", isUploading: false));
        print("Error during file upload: $e");
      }
    } else {
      emit(state.copyWith(errorMessage: "No file selected."));
    }
  }

}

