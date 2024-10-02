import 'package:crm/features/leads/data/models/remienders_model.dart';
import 'package:flutter/material.dart';
import 'package:crm/core/constants/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

import '../../../drawer/presentation/pages/drawer_page.dart';
import '../../../leads/presentation/cubit/reminders_cubit.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _lastPressedAt;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<RemindersCubit>(context).fetchRemindersForCalender();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Check if the back button was pressed within the last 2 seconds
        if (_lastPressedAt == null || DateTime.now().difference(_lastPressedAt!) > Duration(seconds: 2)) {
          _lastPressedAt = DateTime.now();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Press back again to exit the app'),
              duration: Duration(seconds: 2),
            ),
          );
          return false; // Prevent the back navigation
        }
        return true; // Allow the back navigation (close the app)
      },
      child: Scaffold(
        drawer: const DrawerPage(),
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 70),
          child: AppBar(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(25),
              ),
            ),
            backgroundColor: AppColors.primaryYellow,
            title: const Text('Calendar'),
          ),
        ),
        body: SafeArea(
          child: BlocBuilder<RemindersCubit, RemindersState>(
            builder: (context, state) {
              if (state is RemindersLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is RemindersLoaded) {
                return Column(
                  children: [
                    _buildCalendar(state.reminders),
                    _buildEventList(state.reminders),
                  ],
                );
              } else if (state is RemindersError) {
                return Center(child: Text('Error: ${state.message}'));
              }
              return const Center(child: Text('No Events Found'));
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCalendar(List<ReminderModel> reminders) {
    // Map reminders to DateTime keys for TableCalendar
    Map<DateTime, List<ReminderModel>> eventsMap = {};
    for (var reminder in reminders) {
      DateTime reminderDate = DateTime.parse(reminder.date); // Parsing the date string
      if (eventsMap[reminderDate] == null) {
        eventsMap[reminderDate] = [];
      }
      eventsMap[reminderDate]!.add(reminder);
    }

    return Card(
      color: Colors.white,
      margin: const EdgeInsets.all(16),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: TableCalendar(
          firstDay: DateTime.utc(2024, 1, 1),
          lastDay: DateTime.utc(2024, 12, 31),
          focusedDay: _focusedDay,
          calendarFormat: _calendarFormat,
          selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
          },
          onFormatChanged: (format) {
            setState(() => _calendarFormat = format);
          },
          eventLoader: (day) {
            // Use the mapped events for the selected day
            return eventsMap[DateTime(day.year, day.month, day.day)] ?? [];
          },
          calendarStyle: CalendarStyle(
            markersMaxCount: 3,
            markerSize: 6,
            markerDecoration: BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
            selectedDecoration: BoxDecoration(
              color: Colors.blue.shade300,
              shape: BoxShape.circle,
            ),
            todayDecoration: BoxDecoration(
              color: Colors.blue.shade100,
              shape: BoxShape.circle,
            ),
          ),
          headerStyle: const HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
            leftChevronIcon: Icon(Icons.chevron_left, color: Colors.blue),
            rightChevronIcon: Icon(Icons.chevron_right, color: Colors.blue),
            titleTextStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }


  Widget _buildEventList(List<ReminderModel> reminders) {
    // Extract events for the selected or focused day
    DateTime selectedOrFocusedDay = _selectedDay ?? _focusedDay;
    final eventList = reminders.where((reminder) {
      DateTime reminderDate = DateTime.parse(reminder.date);  // Parsing the date string
      return isSameDay(reminderDate, selectedOrFocusedDay);
    }).toList();

    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: eventList.isEmpty
            ? Center(
          child: Text(
            'No events for ${DateFormat('MMMM d, y').format(selectedOrFocusedDay)}',
            style: TextStyle(color: Colors.grey[600]),
          ),
        )
            : ListView.builder(
          itemCount: eventList.length,
          padding: const EdgeInsets.all(8),
          itemBuilder: (context, index) {
            final event = eventList[index];
            return GestureDetector(
              onTap: (){
                showCustomDialog(context, event.date, event.description);
              },
              child: Card(
                color: Colors.white,
                elevation: 2,
                margin: const EdgeInsets.symmetric(vertical: 4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListTile(
                  leading: Icon(
                    Icons.event,
                    color: event.isNotified == '1' ? Colors.green : Colors.red,
                  ),
                  title: Text(
                    event.description,
                    style: TextStyle(
                      color: event.isNotified == '1' ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(event.remindTo),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.grey[400],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

}
void showCustomDialog(BuildContext context, String date, String description) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.white,
        elevation: 8.0,  // Set elevation to make the dialog pop out
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          padding: EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width * 0.8,  // Make the dialog wider
          child: Column(
            mainAxisSize: MainAxisSize.min,  // Only take up as much vertical space as needed
            children: [
              Text(
                'Alert Dialog',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),

              // First TextField (readonly)
              TextField(
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Event Date',
                  border: OutlineInputBorder(borderSide: BorderSide(
                      color: AppColors.primaryYellow
                  )),
                ),
                controller: TextEditingController(text: date),
              ),

              SizedBox(height: 20),

              // Second TextField (readonly)
              TextField(
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.primaryYellow
                    )
                  ),
                ),
                controller: TextEditingController(text: description),
              ),

              SizedBox(height: 30),

              // Close button
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Close'),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}