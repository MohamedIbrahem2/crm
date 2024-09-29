import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';


import '../../data/models/note_model.dart';
import '../../data/repositories/note_repository.dart'; // Your repository to fetch notes

part 'note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  final NoteRepository noteRepository;

  NoteCubit(this.noteRepository) : super(NoteInitial());

  Future<void> fetchNotes(String leadId) async {
    try {
      emit(NoteLoading());
      final notes = await noteRepository.getNotes(leadId);
      emit(NoteLoaded(notes));
    } catch (e) {
      emit(NoteError("Failed to fetch notes"));
    }
  }
}
