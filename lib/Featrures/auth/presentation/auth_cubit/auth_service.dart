import 'dart:convert';
import 'package:http/http.dart' as http;  // You can use dio or other packages as well
// Assuming you have constants like API URL

class AuthService {
  // API endpoint for password reset
  final String _resetPasswordUrl = "${AppConstants.apiBaseUrl}/auth/forgot-password";

  // Method to reset password (send reset email)
  Future<bool> resetPassword(String email) async {
    try {
      // Send a POST request to the backend to reset the password
      final response = await http.post(
        Uri.parse(_resetPasswordUrl),
        body: json.encode({
          'email': email,
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      // Check if the response is successful (e.g., status code 200)
      if (response.statusCode == 200) {
        // You can handle the response here if needed (e.g., a success message from the API)
        return true;
      } else {
        // Handle server error or failed response
        return false;
      }
    } catch (e) {
      // Handle any exceptions (e.g., network issues)
      print("Error resetting password: $e");
      return false;
    }
  }
}

class AppConstants {
  // Base API URL
  static const String apiBaseUrl = 'https://yourapi.com/api';  // Replace with your actual API base URL

  // Authentication API Endpoints
  static const String loginUrl = '$apiBaseUrl/auth/login';
  static const String registerUrl = '$apiBaseUrl/auth/register';
  static const String forgotPasswordUrl = '$apiBaseUrl/auth/forgot-password';
  static const String resetPasswordUrl = '$apiBaseUrl/auth/reset-password';

  // Example of other endpoints you might need
  static const String userProfileUrl = '$apiBaseUrl/user/profile';
  static const String updateProfileUrl = '$apiBaseUrl/user/update-profile';

  // Keys and Secrets
  static const String apiKey = 'your-api-key-here';
  static const String appVersion = '1.0.0';

  // You can store other constants like timeout durations
  static const int requestTimeout = 30;  // in seconds

  // Shared Preferences Keys
  static const String userTokenKey = 'user_token';
  static const String isUserLoggedInKey = 'is_user_logged_in';

  // Error messages
  static const String genericErrorMessage = 'Une erreur est survenue. Veuillez réessayer plus tard.';
  static const String noInternetMessage = 'Pas de connexion Internet. Veuillez vérifier votre connexion.';
}
