import 'package:crm/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/models/assigned_users_model.dart';
import '../../../../data/models/reminder_add_model.dart';
import '../../../cubit/add_remienders_cubit.dart';
import '../../../cubit/assigned_users_cubit.dart';
class AddReminder extends StatefulWidget {
  final String leadId;
  const AddReminder({super.key, required this.leadId});

  @override
  _AddReminderState createState() => _AddReminderState();
}

class _AddReminderState extends State<AddReminder> {
  final _descriptionController = TextEditingController();
  String _selectedDate = '';
  bool _sendEmail = false;
  int? _selectedUserId; // Changed to hold the user ID

  @override
  void initState() {
    super.initState();
    context.read<AssignedUsersCubit>().fetchAssignedUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Set Lead Reminder'),
        backgroundColor: AppColors.secondaryYellow,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocListener<AddRemindersCubit, AddRemindersState>(
        listener: (context, state) {
          if (state is AddReminderAdded) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Reminder added successfully!')),
            );
            Navigator.pop(context);
          } else if (state is AddRemindersError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Date Picker TextField
              TextField(
                readOnly: true,
                controller: TextEditingController(text: _selectedDate),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Date to be notified',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: AppColors.secondaryYellow,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.secondaryYellow, width: 2.0),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      _selectedDate = pickedDate.toIso8601String();
                    });
                  }
                },
              ),
              const SizedBox(height: 16),

              BlocBuilder<AssignedUsersCubit, AssignedUsersState>(
                builder: (context, state) {
                  if (state is AssignedUsersLoading) {
                    return const CircularProgressIndicator();
                  } else if (state is AssignedUsersLoaded) {
                    return DropdownButtonFormField<int>(
                      value: _selectedUserId,
                      items: state.assignedUsers
                          .map<DropdownMenuItem<int>>((AssignedUser user) => DropdownMenuItem<int>(
                        value: user.id,
                        child: Text(user.name),
                      ))
                          .toList(), // Ensure this is a List<DropdownMenuItem<int>>
                      onChanged: (int? newValue) {
                        setState(() {
                          _selectedUserId = newValue; // Update selected user ID
                        });
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Set reminder to',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: AppColors.secondaryYellow,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.secondaryYellow, width: 2.0),
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    );
                  } else if (state is AssignedUsersError) {
                    return Text('Error: ${state.message}');
                  }
                  return const SizedBox(); // Return an empty widget when in loading or error state
                },
              ),


              const SizedBox(height: 16),

              // Description TextField
              TextField(
                controller: _descriptionController,
                maxLines: 3,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Description',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: AppColors.secondaryYellow,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.secondaryYellow, width: 2.0),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Checkbox for sending email
              Row(
                children: [
                  Checkbox(
                    value: _sendEmail,
                    onChanged: (bool? value) {
                      setState(() {
                        _sendEmail = value ?? false;
                      });
                    },
                  ),
                  const Text('Send also an email for this reminder'),
                ],
              ),
              const Spacer(),

              // Save and Close buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Close', style: TextStyle(color: Colors.black)),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondaryYellow,
                    ),
                    onPressed: () {
                      final reminder = ReminderAddModel(
                        description: _descriptionController.text,
                        date: _selectedDate,
                        remindTo: _selectedUserId!, // Update to user ID
                        sendEmail: _sendEmail,
                      );
                      context.read<AddRemindersCubit>().addReminder(reminder,widget.leadId);
                    },
                    child: BlocBuilder<AddRemindersCubit, AddRemindersState>(
                      builder: (context, state) {
                        if (state is AddRemindersLoading) {
                          return const CircularProgressIndicator(color: Colors.black);
                        }
                        return const Text('Save', style: TextStyle(color: Colors.black));
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
