import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class AgendaPage extends StatefulWidget {
  @override
  _AgendaPageState createState() => _AgendaPageState();
}

class _AgendaPageState extends State<AgendaPage> {
  late final ValueNotifier<List<Event>> _selectedEvents;
  late DateTime _focusedDay;
  late DateTime _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;

  final Map<DateTime, List<Event>> _events = {
    DateTime(2024, 9, 15): [Event('Réunion de projet', 'Salle 101')],
    DateTime(2024, 9, 20): [Event('Déjeuner d’équipe', 'Restaurant')],
  };

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _selectedDay = DateTime.now();
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay));
  }

  List<Event> _getEventsForDay(DateTime day) {
    return _events[day] ?? [];
  }

  void _addEvent(DateTime date, Event event) {
    setState(() {
      if (_events[date] != null) {
        _events[date]!.add(event);
      } else {
        _events[date] = [event];
      }
      _selectedEvents.value = _getEventsForDay(_selectedDay);
    });
  }

  void _showAddEventDialog() {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ajouter un Événement'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration:const InputDecoration(labelText: 'Titre'),
            ),
            TextField(
              controller: descriptionController,
              decoration:const InputDecoration(labelText: 'Description'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              final title = titleController.text;
              final description = descriptionController.text;
              if (title.isNotEmpty && description.isNotEmpty) {
                final newEvent = Event(title, description);
                _addEvent(_selectedDay, newEvent);
                Navigator.pop(context);
              }
            },
            child: Text('Ajouter'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Annuler'),
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
              if (!isSameDay(_selectedDay, selectedDay)) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                  _selectedEvents.value = _getEventsForDay(selectedDay);
                });
              }
            },
            eventLoader: (day) => _getEventsForDay(day),
            calendarFormat: _calendarFormat,
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: ValueListenableBuilder<List<Event>>(
              valueListenable: _selectedEvents,
              builder: (context, value, _) {
                return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    final event = value[index];
                    return ListTile(
                      title: Text(event.title),
                      subtitle: Text(event.description),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(event.title),
                            content: Text(event.description),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text('Fermer'),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddEventDialog,
        child: Icon(Icons.add),
        tooltip: 'Ajouter un événement',
      ),
    );
  }
}

class Event {
  final String title;
  final String description;

  Event(this.title, this.description);
}
