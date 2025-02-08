class ApiConfig {
  // Base URL for your backend API
  static const String baseUrl = 'https://powerboxing-app-backend-6s49.onrender.com/api';

  // Authentication Endpoints
  static const String loginEndpoint = '$baseUrl/auth/login';
  static const String signupEndpoint = '$baseUrl/auth/signup';
  static const String getUserEndpoint = '$baseUrl/auth/user'; // <-- Ensure this is correct

  // Session Endpoints
  static const String createSessionEndpoint = '$baseUrl/sessions/start';
  static const String getSessionsEndpoint = '$baseUrl/sessions';

  // Reservation Endpoints
  static const String createReservationEndpoint = '$baseUrl/reservations/create';
  static const String getReservationsEndpoint = '$baseUrl/reservations';
  
  // Results Endpoints
  static const String getResultsEndpoint = '$baseUrl/results';

  // Punching Bag Endpoints
  static const String getPunchingBagsEndpoint = '$baseUrl/punching-bags';
}
