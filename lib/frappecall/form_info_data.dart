import 'dart:convert'; // for json decoding
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

// Initialize the logger
var logger = Logger();

// Future<List<Map<String, dynamic>>> fetchEvents() async {
//   try {
//     final response = await http.get(Uri.parse('http://10.0.2.2:8000/api/v2/method/ex_event_planning.api.get_event_details'));

//     if (response.statusCode == 200) {
//       final responseData = json.decode(response.body);

//       // Debug: Log the full response data
//       logger.d('Response Data: $responseData');

//       if (responseData is Map<String, dynamic> && responseData.containsKey('data')) {
//         final eventsData = responseData['data'];

//         if (eventsData is List) {
//           return List<Map<String, dynamic>>.from(eventsData);
//         } else {
//           throw Exception('Invalid format for "data" field');
//         }
//       } else {
//         throw Exception('Missing or invalid "data" field');
//       }
//     } else {
//       throw Exception('Failed to load events. Status code: ${response.statusCode}');
//     }
//   } catch (e) {
//     logger.e('Error fetching events: $e');
//     rethrow; // Re-throw the error to be caught in the calling function
//   }
// }

// Replace with your API URL
const String apiUrl = 'http://10.0.2.2:8000/api/v2/method/ex_event_planning.api.get_event_details';

Future<List> fetchEvents() async {
  final response = await http.get(Uri.parse(apiUrl));

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);

    // Check if 'data' field exists and is valid
    if (jsonResponse['data'] != null && jsonResponse['data']['status'] == 'success') {
      return jsonResponse['data']['data'];
    } else {
      throw Exception('Invalid format for "data" field');
    }
  } else {
    throw Exception('Failed to load events');
  }
}
