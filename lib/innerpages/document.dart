import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class EventFormPage extends StatefulWidget {
  const EventFormPage({super.key});

  @override
  EventFormPageState createState() => EventFormPageState();
}

class EventFormPageState extends State<EventFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _customer = '';
  String _eventLocation = '';
  String _eventType = '';
  String _expectedGuest = '';
  String _eventCategory = '';
  String _beginsOn = '';
  String _endsOn = '';

  String _description = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Event Form',
          style: TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Event Info
                const Text('Event Info', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Customer',
                    filled: true, // Enables the background color
                    fillColor: const Color.fromARGB(255, 245, 245, 255), // Background color of the field
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0), // Rounded corners
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0), // Rounded corners
                      borderSide: const BorderSide(color:Color.fromARGB(255, 245, 245, 255), width: 1.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0), // Rounded corners
                      borderSide: const BorderSide(color: Color(0xFF6e60fe), width: 2.0),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _customer = value;
                    });
                  },
                ),

                const SizedBox(height: 16),
                // Begins On
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Begins On*',
                    filled: true, // Enables the background color
                    fillColor: const Color.fromARGB(255, 245, 245, 255), // Background color of the field
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0), // Rounded corners
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0), // Rounded corners
                      borderSide: const BorderSide(color:Color.fromARGB(255, 245, 245, 255), width: 1.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0), // Rounded corners
                      borderSide: const BorderSide(color: Color(0xFF6e60fe), width: 2.0),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _beginsOn = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                // Ends On
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Ends On*',
                    filled: true, // Enables the background color
                    fillColor: const Color.fromARGB(255, 245, 245, 255), // Background color of the field
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0), // Rounded corners
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0), // Rounded corners
                      borderSide: const BorderSide(color:Color.fromARGB(255, 245, 245, 255), width: 1.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0), // Rounded corners
                      borderSide: const BorderSide(color: Color(0xFF6e60fe), width: 2.0),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _endsOn = value;
                    });
                  },
                ),

                const SizedBox(height: 16),

                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Event Location',
                    filled: true, // Enables the background color
                    fillColor: const Color.fromARGB(255, 245, 245, 255), // Background color of the field
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0), // Rounded corners
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0), // Rounded corners
                      borderSide: const BorderSide(color:Color.fromARGB(255, 245, 245, 255), width: 1.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0), // Rounded corners
                      borderSide: const BorderSide(color: Color(0xFF6e60fe), width: 2.0),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _eventLocation = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Event Type',
                    filled: true, // Enables the background color
                    fillColor: const Color.fromARGB(255, 245, 245, 255), // Background color of the field
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0), // Rounded corners
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0), // Rounded corners
                      borderSide: const BorderSide(color:Color.fromARGB(255, 245, 245, 255), width: 1.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0), // Rounded corners
                      borderSide: const BorderSide(color: Color(0xFF6e60fe), width: 2.0),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _eventType = value;
                    });
                  },
                ),
                
                const SizedBox(height: 16),

                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Event Category',
                    filled: true, // Enables the background color
                    fillColor: const Color.fromARGB(255, 245, 245, 255), // Background color of the field
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0), // Rounded corners
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0), // Rounded corners
                      borderSide: const BorderSide(color:Color.fromARGB(255, 245, 245, 255), width: 1.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0), // Rounded corners
                      borderSide: const BorderSide(color: Color(0xFF6e60fe), width: 2.0),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _eventCategory = value;
                    });
                  },
                ),
                
                const SizedBox(height: 16),

                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Expected No. Of Guest',
                    filled: true, // Enables the background color
                    fillColor: const Color.fromARGB(255, 245, 245, 255), // Background color of the field
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0), // Rounded corners
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0), // Rounded corners
                      borderSide: const BorderSide(color:Color.fromARGB(255, 245, 245, 255), width: 1.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0), // Rounded corners
                      borderSide: const BorderSide(color: Color(0xFF6e60fe), width: 2.0),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _expectedGuest = value;
                    });
                  },
                ),

                const SizedBox(height: 16),

                // Description
                TextFormField(
                  maxLines: 5,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    filled: true, // Enables the background color
                    fillColor: const Color.fromARGB(255, 245, 245, 255), // Background color of the field
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0), // Rounded corners
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0), // Rounded corners
                      borderSide: const BorderSide(color:Color.fromARGB(255, 245, 245, 255), width: 1.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0), // Rounded corners
                      borderSide: const BorderSide(color: Color(0xFF6e60fe), width: 2.0),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _description = value;
                    });
                  },
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Process the form data
                      // For example, you can send the data to a server
                      if (kDebugMode) {
                        print('Customer: $_customer');
                      }
                      if (kDebugMode) {
                        print('Begins On: $_beginsOn');
                      }
                      if (kDebugMode) {
                        print('Ends On: $_endsOn');
                      }
                      if (kDebugMode) {
                        print('Event Location: $_eventLocation');
                      }
                      if (kDebugMode) {
                        print('Event Type: $_eventType');
                      }
                      if (kDebugMode) {
                        print('Event Category: $_eventCategory');
                      }
                      if (kDebugMode) {
                        print('Expected Guest: $_expectedGuest');
                      }
                      if (kDebugMode) {
                        print('Description: $_description');
                      }
                    }
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}