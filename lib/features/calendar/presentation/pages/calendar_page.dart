

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../drawer/presentation/pages/drawer_page.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  final Map<DateTime, List<Event>> _events = {
    DateTime.utc(2024, 1, 1): [Event('Go Grow', EventType.start)],
    DateTime.utc(2024, 1, 2): [Event('Go Grow', EventType.start)],
    DateTime.utc(2024, 1, 3): [Event('Go Grow', EventType.start)],
    DateTime.utc(2024, 1, 10): [Event('Go Grow', EventType.start)],
    DateTime.utc(2024, 1, 11): [Event('Go Grow', EventType.start)],
    DateTime.utc(2024, 1, 20): [Event('Go Grow', EventType.start)],
    DateTime.utc(2024, 1, 26): [Event('Go Grow', EventType.end)],
    DateTime.utc(2024, 1, 28): [Event('Go Grow', EventType.end)],
    DateTime.utc(2024, 1, 29): [Event('Go Grow', EventType.end)],
  };

  List<Event> _getEventsForDay(DateTime day) {
    return _events[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerPage(),
      appBar: AppBar(
        title: const Text('Calendar'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2023, 1, 1),
            lastDay: DateTime.utc(2025, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            eventLoader: _getEventsForDay,
            calendarStyle: const CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
              ),
              markerDecoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
            ),
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
            ),
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: ListView.builder(
              itemCount: _getEventsForDay(_selectedDay).length,
              itemBuilder: (context, index) {
                final event = _getEventsForDay(_selectedDay)[index];
                return ListTile(
                  title: Text(event.title),
                  leading: CircleAvatar(
                    backgroundColor: event.type == EventType.start
                        ? Colors.green
                        : Colors.red,
                    child: Text(
                      event.type == EventType.start ? 'S' : 'E',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

enum EventType { start, end }

class Event {
  final String title;
  final EventType type;

  Event(this.title, this.type);
}
