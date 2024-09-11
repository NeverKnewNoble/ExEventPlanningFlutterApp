import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:logger/logger.dart';

// Initialize the logger
var logger = Logger();

Future<int> fetchCompletedEventCount() async {
  try {
    // Define the API endpoint
    var url = Uri.parse('http://127.0.0.1:8000/api/v2/method/ex_event_planning.api.get_comp_doc_count');

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

      // Check if the response contains the 'data' field and return its value
      if (responseData.containsKey('data')) {
        return responseData['data'];
      } else {
        logger.e('Unexpected response format: Missing "data" field');
        throw Exception('Unexpected response format');
      }
    } else {
      logger.w('Failed to fetch data. Status code: ${response.statusCode}, Response body: ${response.body}');
      throw Exception('Failed to fetch data');
    }
  } catch (e) {
    logger.e('Error fetching open event count', error: e);
    rethrow; // Rethrow the error
  }
}
