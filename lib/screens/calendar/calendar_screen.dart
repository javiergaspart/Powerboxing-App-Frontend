import 'package:flutter/material.dart';
import 'package:fitboxing_app/models/user_model.dart';
import 'package:fitboxing_app/services/session_service.dart';
import 'package:intl/intl.dart';

class CalendarScreen extends StatefulWidget {
  final UserModel user;
  CalendarScreen({required this.user});

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  List<DateTime> next14Days = [];
  Map<String, List<dynamic>> sessionsByDate = {};
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _generateNext14Days();
    _fetchSessions();
  }

  void _generateNext14Days() {
    DateTime today = DateTime.now();
    for (int i = 0; i < 14; i++) {
      next14Days.add(today.add(Duration(days: i)));
    }
  }

  void _fetchSessions() async {
    try {
      Map<String, List<dynamic>> fetchedSessions = await SessionService.fetchAvailableSessions();
      setState(() {
        sessionsByDate = fetchedSessions;
        _loading = false;
      });
    } catch (e) {
      setState(() => _loading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error fetching sessions: ${e.toString()}")),
      );
    }
  }

  void _bookSession(String sessionId) async {
    bool success = await SessionService.bookSession(widget.user.id, sessionId);
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Session booked successfully!")),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Booking failed. Try again.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: next14Days.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Book a Session"),
          bottom: TabBar(
            isScrollable: true,
            tabs: next14Days.map((date) {
              return Tab(text: "${DateFormat('EEE dd/MM').format(date)}");
            }).toList(),
          ),
        ),
        body: _loading
            ? Center(child: CircularProgressIndicator())
            : TabBarView(
                children: next14Days.map((date) {
                  String formattedDate = DateFormat('yyyy-MM-dd').format(date);
                  List<dynamic> sessions = sessionsByDate[formattedDate] ?? [];
                  
                  return sessions.isEmpty
                      ? Center(child: Text("No sessions available"))
                      : ListView.builder(
                          itemCount: sessions.length,
                          itemBuilder: (context, index) {
                            var session = sessions[index];
                            return ListTile(
                              title: Text("${session['time']} - ${session['availableSlots']} slots left"),
                              trailing: ElevatedButton(
                                onPressed: () => _bookSession(session['id']),
                                child: Text("Book"),
                              ),
                            );
                          },
                        );
                }).toList(),
              ),
      ),
    );
  }
}
