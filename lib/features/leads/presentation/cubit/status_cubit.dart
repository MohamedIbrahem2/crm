// status_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../data/repositories/status_repository.dart';
import 'status_state.dart'; // Import the state file

class StatusCubit extends Cubit<StatusState> {
  final StatusRepository statusRepository;

  StatusCubit(this.statusRepository) : super(StatusInitial());

  Future<void> fetchStatusCounts() async {
    try {
      emit(StatusLoading());

      // Fetch the status counts from the repository
      final statusCounts = await statusRepository.fetchStatusCounts();

      // Check if the cubit is still open before emitting a new state
      if (!isClosed) {
        emit(StatusLoaded(statusCounts));
      }
    } catch (e) {
      // Check if the cubit is still open before emitting an error state
      if (!isClosed) {
        emit(StatusError('Failed to load status counts: $e'));
      }
    }
  }

  @override
  Future<void> close() {
    // Any additional cleanup if necessary
    return super.close();
  }
}
