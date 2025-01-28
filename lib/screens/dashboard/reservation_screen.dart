import 'package:flutter/material.dart';
import '../../models/user_model.dart';
import '../../services/mongo_service.dart';

class ReservationScreen extends StatefulWidget {
  final UserModel user;

  ReservationScreen({required this.user});

  @override
  _ReservationScreenState createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  late MongoService _mongoService;
  List<Map<String, dynamic>> _sessions = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _mongoService = MongoService();
    _loadSessions();
  }

  Future<void> _loadSessions() async {
    await _mongoService.connect();
    List<Map<String, dynamic>> sessions = await _mongoService.getSessions();
    setState(() {
      _sessions = sessions;
      _isLoading = false;
    });
    await _mongoService.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reserve a Session')),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _sessions.isEmpty
          ? Center(child: Text('No available sessions'))
          : ListView.builder(
        itemCount: _sessions.length,
        itemBuilder: (context, index) {
          var session = _sessions[index];
          return Card(
            child: ListTile(
              title: Text('Session on ${session['date']}'),
              subtitle: Text('Available slots: ${session['slots']}'),
              trailing: ElevatedButton(
                onPressed: () {
                  if (session['slots'] > 0) {
                    _bookSession(session['_id']);
                  }
                },
                child: Text('Book Now'),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _bookSession(String sessionId) async {
    await _mongoService.connect();
    await _mongoService.bookSession(sessionId);
    await _mongoService.close();
    _loadSessions();
  }
}



