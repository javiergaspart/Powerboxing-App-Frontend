// lib/screens/calendar/calendar_screen.dart
import 'package:flutter/material.dart';
import 'package:fitboxing_app/models/user_model.dart';
import 'package:fitboxing_app/services/session_service.dart';

class CalendarScreen extends StatefulWidget {
  final UserModel user;

  CalendarScreen({required this.user});

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  Map<String, List<dynamic>> sessionData = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchSessions();
  }

  void _fetchSessions() async {
    List<dynamic> sessions = await SessionService.fetchAvailableSessions();
    Map<String, List<dynamic>> organizedSessions = {};

    for (var session in sessions) {
      String date = session['date'];
      if (!organizedSessions.containsKey(date)) {
        organizedSessions[date] = [];
      }
      organizedSessions[date]?.add(session);
    }

    setState(() {
      sessionData = organizedSessions;
      _isLoading = false;
    });
  }

  void _bookSession(String sessionId) async {
    bool success = await SessionService.bookSession(widget.user.id, sessionId);
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Session booked successfully!')),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Booking failed, please try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Book a Session')),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView(
              children: sessionData.keys.map((date) {
                return ExpansionTile(
                  title: Text(date, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  children: sessionData[date]!.map((session) {
                    return ListTile(
                      title: Text('Time: ${session['time']} - Slots: ${session['available_slots']}/20'),
                      trailing: ElevatedButton(
                        onPressed: () => _bookSession(session['_id']),
                        child: Text('Book'),
                      ),
                    );
                  }).toList(),
                );
              }).toList(),
            ),
    );
  }
}
