import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../../data/repositories/status_repository.dart';
import 'status_state.dart'; // Make sure to import your state file

class StatusCubit extends Cubit<StatusState> {
  final StatusRepository statusRepository;
  bool _isClosed = false;

  StatusCubit(this.statusRepository) : super(StatusInitial());

  @override
  Future<void> close() {
    _isClosed = true; // Set the flag to true
    return super.close();
  }

  Future<void> fetchStatus() async {
    if (_isClosed) return; // Check if cubit is closed

    try {
      emit(StatusLoading());
      final statusNames = await statusRepository.fetchStatusNames(); // Fetch status names

      if (statusNames.isNotEmpty) {
        emit(StatusLoaded(statusNames));
      } else {
        emit(StatusError("No status names found"));
      }
    } catch (e) {
      print('Error fetching statuses: $e');
      if (!_isClosed) emit(StatusError("Failed to load status data"));
    }
  }

}
