import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/session_model.dart';
import '../constants/urls.dart';

class SessionService {
  // Fetch upcoming sessions for the user
  Future<List<Session>> getUpcomingSessions(String userId) async {
    try {
      final url = Uri.parse('${AppUrls.baseUrl}/sessions/upcoming/$userId');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        return jsonResponse.map((session) => Session.fromJson(session)).toList();
      } else if (response.statusCode == 404) {
        // Handle case when no upcoming sessions are found
        return [];
      } else {
        throw Exception('Failed to load upcoming sessions');
      }
    } catch (e) {
      print('Error fetching upcoming sessions: $e');
      return [];
    }
  }

  // Fetch previous sessions for the user
  Future<List<Session>> getPreviousSessions(String userId) async {
    try {
      final url = Uri.parse('${AppUrls.baseUrl}/sessions/previous/$userId');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        return jsonResponse.map((session) => Session.fromJson(session)).toList();
      } else if (response.statusCode == 404) {
        // Handle case when no previous sessions are found
        return [];
      } else {
        throw Exception('Failed to load previous sessions');
      }
    } catch (e) {
      print('Error fetching previous sessions: $e');
      return [];
    }
  }

  // Book a session for the user
  Future<bool> bookSession(String userId, String sessionId, String location) async {
    try {
      final url = Uri.parse('${AppUrls.baseUrl}/sessions/book');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'userId': userId,
          'sessionId': sessionId,
          'location': location,
        }),
      );

      if (response.statusCode == 200) {
        return true; // Booking successful
      } else {
        throw Exception('Failed to book session');
      }
    } catch (e) {
      print('Error booking session: $e');
      return false;
    }
  }

  // Cancel a booked session for the user
  Future<bool> cancelSession(String bookingId) async {
    try {
      final url = Uri.parse('${AppUrls.baseUrl}/sessions/cancel/$bookingId');
      final response = await http.delete(url);

      if (response.statusCode == 200) {
        return true; // Cancellation successful
      } else {
        throw Exception('Failed to cancel session');
      }
    } catch (e) {
      print('Error canceling session: $e');
      return false;
    }
  }
}

