import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class AgendaPage extends StatefulWidget {
  @override
  _AgendaPageState createState() => _AgendaPageState();
}

class _AgendaPageState extends State<AgendaPage> {
  late final ValueNotifier<List<Event>> _selectedEvents;
  late DateTime _focusedDay;
  late DateTime _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;

  final Map<DateTime, List<Event>> _events = {};

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _selectedDay = DateTime.now();
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay));

    _fetchEventsFromFirestore(); // Fetch events on initialization
  }

  Future<void> _fetchEventsFromFirestore() async {
    final eventsCollection = FirebaseFirestore.instance.collection('events');
    final querySnapshot = await eventsCollection.get();

    setState(() {
      for (var doc in querySnapshot.docs) {
        final data = doc.data();
        final dateString = data['date']; // Date in "dd-MM-yyyy" format
        final title = data['event_name'];
        final description = data['description'];

        final DateTime eventDate = DateFormat('dd-MM-yyyy').parse(dateString);

        final event = Event(title, description, eventDate);
        _addEvent(eventDate, event);
      }

      if (_events.isNotEmpty) {
        _focusedDay = _events.keys.first;
        _selectedDay = _events.keys.first;

        _selectedEvents.value = _getEventsForDay(_selectedDay);
      }
    });
  }

  List<Event> _getEventsForDay(DateTime day) {
    return _events[DateTime(day.year, day.month, day.day)] ?? [];
  }

  List<Event> _getAllEvents() {
    return _events.values.expand((events) => events).toList();
  }

  void _addEvent(DateTime date, Event event) {
    setState(() {
      final normalizedDate = DateTime(date.year, date.month, date.day);
      if (_events[normalizedDate] != null) {
        _events[normalizedDate]!.add(event);
      } else {
        _events[normalizedDate] = [event];
      }
      _selectedEvents.value = _getEventsForDay(_selectedDay);
    });
  }

  void _showEventDetailsDialog(Event event) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(event.title),
        content: Text(event.description),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agenda'),
      ),
      body: Column(
        children: [
          TableCalendar<Event>(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2100, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
                _selectedEvents.value = _getEventsForDay(_selectedDay);
              });
            },
            eventLoader: (day) => _getEventsForDay(day),
            calendarFormat: _calendarFormat,
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            calendarBuilders: CalendarBuilders(
              markerBuilder: (context, date, events) {
                if (events.isNotEmpty) {
                  return Positioned(
                    bottom: 1,
                    child: _buildEventMarker(events.length),
                  );
                }
                return SizedBox.shrink();
              },
              defaultBuilder: (context, date, _) {
                if (_getEventsForDay(date).isNotEmpty) {
                  return Container(
                    margin: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.lightBlueAccent.withOpacity(0.5), // Background for event days
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      '${date.day}',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }
                return null;
              },
              selectedBuilder: (context, date, _) {
                return Container(
                  margin: const EdgeInsets.all(4.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.blue, // Selected day color
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    '${date.day}',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: ListView(
              children: _getAllEvents().map((event) {
                bool isSelectedDayEvent = isSameDay(event.date, _selectedDay);
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                  shape: isSelectedDayEvent
                      ? RoundedRectangleBorder(
                          side: BorderSide(color: Colors.blueAccent, width: 2.0),
                          borderRadius: BorderRadius.circular(10.0),
                        )
                      : null,
                  child: ListTile(
                    title: Text(
                      event.title,
                      style: TextStyle(
                        color: isSelectedDayEvent ? Colors.blueAccent : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(event.description),
                    onTap: () {
                      setState(() {
                        _selectedDay = event.date;
                        _focusedDay = event.date;
                        _selectedEvents.value = _getEventsForDay(_selectedDay);
                      });
                      _showEventDetailsDialog(event);
                    },
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddEventDialog,
        child: Icon(Icons.add),
        tooltip: 'Add Event',
      ),
    );
  }

  Widget _buildEventMarker(int eventCount) {
    return Container(
      width: 16,
      height: 16,
      decoration: BoxDecoration(
        color: Colors.green, // Green dot color
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          '$eventCount',
          style: TextStyle(color: Colors.white, fontSize: 12),
        ),
      ),
    );
  }
  // ok ?? yes babe

  void _showAddEventDialog() {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Event'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              final title = titleController.text;
              final description = descriptionController.text;
              if (title.isNotEmpty && description.isNotEmpty) {
                final newEvent = Event(title, description, _selectedDay);
                _addEvent(_selectedDay, newEvent);
                Navigator.pop(context);
              }
            },
            child: Text('Add'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }
}

class Event {
  final String title;
  final String description;
  final DateTime date;

  Event(this.title, this.description, this.date);
}
