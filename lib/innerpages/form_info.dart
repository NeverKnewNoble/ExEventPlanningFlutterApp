import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ex_event_planning/frappecall/form_info_data.dart';

class FormInfo extends StatefulWidget {
  final Map<String, dynamic> event;

  const FormInfo({super.key, required this.event});

  @override
  FormInfoState createState() => FormInfoState();
}

class FormInfoState extends State<FormInfo> {
  final _formKey = GlobalKey<FormState>(); // Define _formKey
  List events = [];
  bool isLoading = true;
  String? errorMessage;
  
  // Fields to populate
  late String _customer;
  late String _beginsOn;
  late String _endsOn;
  late String _eventLocation;
  late String _eventType;
  late String _expectedGuest;
  late String _eventCategory;
  late String _description;

  @override
  void initState() {
    super.initState();
    _initializeFields(); // Initialize the fields with the passed event
    loadEvents(); // Load events from the API
  }

  // Initialize form fields with event data
  void _initializeFields() {
    _customer = widget.event['customer'] ?? 'No data';
    _beginsOn = widget.event['begins_on'] ?? 'No data';
    _endsOn = widget.event['ends_on'] ?? 'No data';
    _eventLocation = widget.event['event_location'] ?? 'No data';
    _eventType = widget.event['event_type'] ?? 'No data';
    _expectedGuest = widget.event['expected_no_of_guest']?.toString() ?? 'No data';
    _eventCategory = widget.event['event_class'] ?? 'No data';
    _description = widget.event['description'] ?? 'No data';
  }

  // Fetch the list of events from the API
  Future<void> loadEvents() async {
    try {
      List fetchedEvents = await fetchEvents();
      setState(() {
        events = fetchedEvents;

        // Find the event by the passed "name" and update the form fields
        final matchedEvent = events.firstWhere(
          (event) => event['name'] == widget.event['name'],
          orElse: () => null,
        );
        
        if (matchedEvent != null) {
          _customer = matchedEvent['customer'] ?? 'No data';
          _beginsOn = matchedEvent['begins_on'] ?? 'No data';
          _endsOn = matchedEvent['ends_on'] ?? 'No data';
          _eventLocation = matchedEvent['event_location'] ?? 'No data';
          _eventType = matchedEvent['event_type'] ?? 'No data';
          _expectedGuest = matchedEvent['expected_no_of_guest']?.toString() ?? 'No data';
          _eventCategory = matchedEvent['event_class'] ?? 'No data';
          _description = matchedEvent['description'] ?? 'No data';
        }
        isLoading = false; // Set loading to false after data is fetched
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching events: $e'); // Debug statement
      }
      setState(() {
        isLoading = false; // Set loading to false in case of error
        errorMessage = 'Failed to load event details';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.event['name'] ?? 'Event Details', // Set the app bar title as the event name
          style: const TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        errorMessage!,
                        style: const TextStyle(color: Colors.red, fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: loadEvents,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : Form(
                  key: _formKey, // Assign _formKey to the Form widget
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Event Info', style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        buildTextField('Customer', _customer, (val) => setState(() => _customer = val)),
                        const SizedBox(height: 16),
                        buildTextField('Begins On*', _beginsOn, (val) => setState(() => _beginsOn = val), isRequired: true),
                        const SizedBox(height: 16),
                        buildTextField('Ends On*', _endsOn, (val) => setState(() => _endsOn = val), isRequired: true),
                        const SizedBox(height: 16),
                        buildTextField('Event Location', _eventLocation, (val) => setState(() => _eventLocation = val)),
                        const SizedBox(height: 16),
                        buildTextField('Event Type', _eventType, (val) => setState(() => _eventType = val)),
                        const SizedBox(height: 16),
                        buildTextField('Event Category', _eventCategory, (val) => setState(() => _eventCategory = val)),
                        const SizedBox(height: 16),
                        buildTextField('Expected No. Of Guest', _expectedGuest, (val) => setState(() => _expectedGuest = val)),
                        const SizedBox(height: 16),
                        buildTextField('Description', _description, (val) => setState(() => _description = val), maxLines: 5),
                      ],
                    ),
                  ),
                ),
    );
  }
}

Widget buildTextField(
  String label,
  String initialValue,
  Function(String) onChanged, {
  int maxLines = 1,
  bool isRequired = false,
  bool isReadOnly = true, // Control read-only state
}) {
  return TextFormField(
    initialValue: initialValue,
    onChanged: onChanged,
    maxLines: maxLines,
    enabled: !isReadOnly,
    style: const TextStyle(color: Colors.black), // Set text color to black
    decoration: InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.black), // Set label color to black
      filled: true,
      fillColor: const Color.fromARGB(255, 245, 245, 255), // Background color
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(
          color: Color.fromARGB(255, 245, 245, 255),
          width: 1.0,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(
          color: Color(0xFF6e60fe),
          width: 2.0,
        ),
      ),
      errorText: isRequired && initialValue.isEmpty ? 'This field is required' : null,
    ),
    validator: (value) {
      if (isRequired && (value == null || value.isEmpty)) {
        return 'Please enter $label';
      }
      return null;
    },
  );
}

