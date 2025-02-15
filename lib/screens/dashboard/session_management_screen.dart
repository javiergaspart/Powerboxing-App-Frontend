import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fitboxing_app/services/auth_service.dart';
import 'package:fitboxing_app/services/api_service.dart';
import 'dart:convert';

class SessionManagementScreen extends StatefulWidget {
  @override
  _SessionManagementScreenState createState() => _SessionManagementScreenState();
}

class _SessionManagementScreenState extends State<SessionManagementScreen> {
  List<dynamic> sessions = [];
  
  @override
  void initState() {
    super.initState();
    _loadSessions();
  }

  void _loadSessions() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final trainerId = authService.loggedInUser?["_id"];
    
    if (trainerId == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Trainer ID not found")));
      return;
    }
    
    var response = await ApiService.get("fitboxing/sessions/trainer/$trainerId");
    if (response != null) {
      setState(() {
        sessions = jsonDecode(response);
      });
    }
  }

  void _deleteSession(String sessionId) async {
    var response = await ApiService.delete("fitboxing/sessions/$sessionId");
    if (response != null) {
      setState(() {
        sessions.removeWhere((session) => session["_id"] == sessionId);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Session Management")),
      body: ListView.builder(
        itemCount: sessions.length,
        itemBuilder: (context, index) {
          var session = sessions[index];
          return ListTile(
            title: Text("Session at ${session['dateTime']}"),
            subtitle: Text("Participants: ${session['participants'].length}/20"),
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () => _deleteSession(session["_id"]),
            ),
          );
        },
      ),
    );
  }
}
