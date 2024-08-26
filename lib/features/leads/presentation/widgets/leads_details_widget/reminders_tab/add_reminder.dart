import 'package:flutter/material.dart';
import 'package:sales_crm/core/helpers/extensions.dart';

import '../../../../../../core/routing/app_routes.dart';


class AddReminder extends StatelessWidget {
  const AddReminder({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Set Lead Reminder'),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.black),
          onPressed: () {
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Date to be notified',
                suffixIcon: Icon(Icons.calendar_today),
              ),
              onTap: () {
                // Handle date picker here
              },
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<String>(
              items: ['Go Grow', 'Another Option']
                  .map((String value) => DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              ))
                  .toList(),
              onChanged: (String? newValue) {
                // Handle reminder change
              },
              decoration: InputDecoration(
                labelText: 'Set reminder to',
              ),
            ),
            SizedBox(height: 16),
            TextField(
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Description',
                alignLabelWithHint: true,
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Checkbox(
                  value: false,
                  onChanged: (bool? value) {
                    // Handle checkbox state change
                  },
                ),
                Text('Send also an email for this reminder'),
              ],
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    // Handle Close button press
                  },
                  child: Text('Close'),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    // Handle Save button press
                  },
                  child: Text('Save'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
