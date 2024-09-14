import 'dart:convert'; // for json decoding
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

// Initialize the logger
var logger = Logger();

// Define a function to fetch events from the API
Future<List<Map<String, dynamic>>> fetchEvents() async {
  try {
    var url = Uri.parse('http://10.0.2.2:8000/api/v2/method/ex_event_planning.api.get_event_planning_details');
    var response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    logger.i('Response body: ${response.body}');

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);

      logger.i('Parsed response data: $responseData');

      // Ensure the response contains a 'data' field with nested 'data'
      if (responseData is Map<String, dynamic> &&
          responseData['data'] is Map<String, dynamic> &&
          responseData['data']['data'] is List) {
        // Return the list of events from the nested 'data' field
        return List<Map<String, dynamic>>.from(responseData['data']['data']);
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
