import 'dart:convert'; // for json decoding
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

// Initialize the logger
var logger = Logger();

// Define a function to fetch events from the API
Future<List<Map<String, dynamic>>> fetchEvents() async {
  try {
    // Define the API endpoint
    var url = Uri.parse('http://10.0.2.2:8000/api/v2/method/ex_event_planning.api.get_listview');

    // Send a GET request
    var response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    // Log the response body for debugging
    logger.i('Response body: ${response.body}');

    // Check if the request was successful
    if (response.statusCode == 200) {
      // Parse the response body
      var responseData = jsonDecode(response.body);

      // Ensure the response contains a 'data' field and is a list
      if (responseData is Map<String, dynamic> && responseData['data'] is List) {
        // Return the list of events from the 'data' field
        return List<Map<String, dynamic>>.from(responseData['data']);
      } else {
        logger.e('Unexpected response format: Missing or invalid "data" field');
        throw Exception('Unexpected response format');
      }
    } else {
      logger.w('Failed to fetch events. Status code: ${response.statusCode}, Response body: ${response.body}');
      throw Exception('Failed to fetch events');
    }
  } catch (e) {
    logger.e('Error fetching events', error: e);
    rethrow; // Rethrow the error
  }
}

