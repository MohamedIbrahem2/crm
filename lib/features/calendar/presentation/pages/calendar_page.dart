import 'package:flutter/material.dart';
import 'package:sales_crm/core/constants/app_colors.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

import '../../../drawer/presentation/pages/drawer_page.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  Map<DateTime, List<Event>> _events = {
    DateTime(2024, 9, 3): [
      Event('Go Grow'),
      Event('Go Grow'),
      Event('Go Grow', isRed: true),
    ],
    DateTime(2024, 9, 4): [
      Event('Go Grow'),
      Event('Go Grow', isRed: true),
    ],
    DateTime(2024, 9, 5): [
      Event('Go Grow'),
      Event('Go Grow', isRed: true),
    ],
  };

  List<Event> _getEventsForDay(DateTime day) {
    return _events[DateTime(day.year, day.month, day.day)] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerPage(),
      appBar: AppBar(
        title: Text('Calendar'),
        backgroundColor: AppColors.primaryYellow,
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildCalendar(),
            _buildEventList(),
          ],
        ),
      ),
    );
  }


  Widget _buildCalendar() {
    return Card(
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
          eventLoader: _getEventsForDay,
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

  Widget _buildEventList() {
    final events = _getEventsForDay(_selectedDay ?? _focusedDay);
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: events.isEmpty
            ? Center(
          child: Text(
            'No events for ${DateFormat('MMMM d, y').format(_selectedDay ?? _focusedDay)}',
            style: TextStyle(color: Colors.grey[600]),
          ),
        )
            : ListView.builder(
          itemCount: events.length,
          padding: const EdgeInsets.all(8),
          itemBuilder: (context, index) {
            final event = events[index];
            return Card(
              elevation: 2,
              margin: const EdgeInsets.symmetric(vertical: 4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListTile(
                leading: Icon(
                  Icons.event,
                  color: event.isRed ? Colors.red : Colors.green,
                ),
                title: Text(
                  event.title,
                  style: TextStyle(
                    color: event.isRed ? Colors.red : Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.grey[400],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class Event {
  final String title;
  final bool isRed;

  Event(this.title, {this.isRed = false});
}