import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../data/models/note_model.dart';
import '../../cubit/add_note_cubit.dart';
import '../../cubit/note_cubit.dart';

class NoteTab extends StatefulWidget {
  final String leadId;
  const NoteTab({super.key, required this.leadId});

  @override
  _NoteTabState createState() => _NoteTabState();
}


class _NoteTabState extends State<NoteTab> {
  final TextEditingController _noteController = TextEditingController();
  @override
  void initState(){
    super.initState();
    context.read<NoteCubit>().fetchNotes(widget.leadId);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Note input field
              TextField(
                controller: _noteController,
                maxLines: 3,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your note here...',
                ),
              ),
              const SizedBox(height: 16),

              // Button to add the note
              BlocConsumer<AddNoteCubit, AddNoteState>(
                listener: (context, state) {
                  if (state is AddNoteSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Note added successfully!')),
                    );
                    // Clear the input field after success
                    _noteController.clear();
                    context.read<NoteCubit>().fetchNotes(widget.leadId);
                  } else if (state is AddNoteError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message)),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is AddNoteLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return ElevatedButton(
                    onPressed: () {
                      if (_noteController.text.isNotEmpty) {
                        final newNote = Note(
                          description: _noteController.text,
                          createdAt: DateTime.now().toString(),
                        );

                        context.read<AddNoteCubit>().addNote(newNote,widget.leadId);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Please enter a note!')),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryYellow,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text('Add Note'),
                  );
                },
              ),

              const SizedBox(height: 24),

              // List of notes
              BlocBuilder<NoteCubit, NoteState>(
                builder: (context, state) {
                  if (state is NoteLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is NoteLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  else if (state is NoteLoaded) {
                    return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.notes.length,
                      separatorBuilder: (context, index) => const Divider(),
                      itemBuilder: (context, index) {
                        return NoteItem(note: state.notes[index]);
                      },
                    );
                  } else if (state is NoteError) {
                    return Center(child: Text(state.message));
                  }
                  return const SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NoteItem extends StatelessWidget {
  final Note note;

  const NoteItem({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            backgroundColor: Colors.orange,
            child: Icon(Icons.person, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Go Grow",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Note added: ${note.createdAt}',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 4),
                Text(
                  note.description ?? 'No content',
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
