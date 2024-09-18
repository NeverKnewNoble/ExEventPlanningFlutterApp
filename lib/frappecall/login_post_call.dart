// import 'dart:convert';  // To convert the response from JSON
// import 'package:http/http.dart' as http;

// // Function to verify login credentials using the Frappe API
// Future<Map<String, dynamic>> verifyLogin(String email, String password) async {
//   const url = 'http://10.0.2.2:8000/api/v2/method/ex_event_planning.api.verify_login'; // Replace with your API endpoint
//   final response = await http.post(
//     Uri.parse(url),
//     headers: {
//       'Content-Type': 'application/json',
//     },
//     body: json.encode({
//       'username': email,  // Ensure you're passing the correct field name
//       'password': password,
//     }),
//   );

//   if (response.statusCode == 200) {
//     return json.decode(response.body);
//   } else {
//     throw Exception('Failed to log in');
//   }
// }

import 'dart:convert';
import 'package:http/http.dart' as http;

// Function to verify login credentials using the Frappe API
Future<Map<String, dynamic>> verifyLogin(String email, String password) async {
  const url = 'http://10.0.2.2:8000/api/v2/method/ex_event_planning.api.verify_login'; // Replace with your API endpoint
  final response = await http.post(
    Uri.parse(url),
    headers: {
      'Content-Type': 'application/json',
    },
    body: json.encode({
      'username': email,  // Ensure you're passing the correct field name
      'password': password,
    }),
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> responseData = json.decode(response.body);

    // Check if the login was successful
    if (responseData['data']['status'] == 'success') {
      // Extract full name from the response
      final String fullName = responseData['data']['full_name'] ?? 'No full name provided';
      return {
        'status': responseData['data']['status'],
        'message': responseData['data']['message'],
        'full_name': fullName,
      };
    } else {
      // Handle login failure
      return {
        'status': responseData['data']['status'],
        'message': responseData['data']['message'],
        'full_name': null,
      };
    }
  } else {
    throw Exception('Failed to log in');
  }
}
