import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/models/note_model.dart';
import '../../data/repositories/note_repository.dart'; // Your note model

part 'add_note_state.dart';

class AddNoteCubit extends Cubit<AddNoteState> {
  final NoteRepository noteRepository;

  AddNoteCubit(this.noteRepository) : super(AddNoteInitial());

  Future<void> addNote(Note note,String leadId) async {
    try {
      emit(AddNoteLoading());
      await noteRepository.addNote(note,leadId);
      emit(AddNoteSuccess());
    } catch (e) {
      emit(AddNoteError("Failed to add note"));
    }
  }
}
