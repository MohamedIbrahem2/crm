import 'package:flutter/material.dart';

import '../../../../../core/constants/app_colors.dart';

class NoteTab extends StatefulWidget {
  const NoteTab({super.key});
  @override
  _NoteTabState createState() => _NoteTabState();
}

class _NoteTabState extends State<NoteTab> {
  int _selectedOption = 1;
  final TextEditingController _noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _noteController,
                maxLines: 3,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your note here...',
                ),
              ),
              const SizedBox(height: 16),
              // Row(
              //   children: [
              //     Expanded(
              //       child: RadioListTile<int>(
              //         title: const Text('I got in touch with this lead'),
              //         value: 0,
              //         groupValue: _selectedOption,
              //         onChanged: (value) => setState(() => _selectedOption = value!),
              //       ),
              //     ),
              //   ],
              // ),
              // Row(
              //   children: [
              //     Expanded(
              //       child: RadioListTile<int>(
              //         title: const Text('I have not contacted this lead'),
              //         value: 1,
              //         groupValue: _selectedOption,
              //         onChanged: (value) => setState(() => _selectedOption = value!),
              //       ),
              //     ),
              //   ],
              // ),
              // const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Implement note adding functionality
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryYellow,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Text('Add Note'),
              ),
              const SizedBox(height: 24),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 4,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  return const NoteItem();
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
  const NoteItem({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: Colors.orange,
            child: Icon(Icons.person, color: Colors.white),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Go Grow',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Noted added: 2024-08-22 21:00:00',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                SizedBox(height: 4),
                Text(
                  'Lorem ipsum, or lipsum as it is sometimes known, is dummy text used in laying out print, graphic or web designs.',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}