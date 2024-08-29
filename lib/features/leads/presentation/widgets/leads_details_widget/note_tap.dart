import 'package:flutter/material.dart';

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
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _noteController,
                maxLines: 3,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your note here...',
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile<int>(
                      title: Text('I got in touch with this lead'),
                      value: 0,
                      groupValue: _selectedOption,
                      onChanged: (value) => setState(() => _selectedOption = value!),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile<int>(
                      title: Text('I have not contacted this lead'),
                      value: 1,
                      groupValue: _selectedOption,
                      onChanged: (value) => setState(() => _selectedOption = value!),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              ElevatedButton(
                child: Text('Add Note'),
                onPressed: () {
                  // Implement note adding functionality
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: EdgeInsets.symmetric(vertical: 12),
                ),
              ),
              SizedBox(height: 24),
              ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 4,
                separatorBuilder: (context, index) => Divider(),
                itemBuilder: (context, index) {
                  return NoteItem();
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
  @override
  Widget build(BuildContext context) {
    return Padding(
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