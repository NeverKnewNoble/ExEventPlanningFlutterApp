import 'package:flutter/material.dart';
import 'frappecall/frappe_api.dart'; // Import the API file

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Frappe Event Counter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  MyHomePageState createState() => MyHomePageState(); // Remove the underscore
}

class MyHomePageState extends State<MyHomePage> { // Remove the underscore
  String _eventCount = ''; // To store the event count
  bool _isLoading = false; // To manage loading state
  String _errorMessage = ''; // To display errors if any

  // Function to fetch event count and update the UI
  Future<void> _getEventCount() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      var count = await fetchOpenEventCount(); // Fetch the count
      setState(() {
        _eventCount = count.toString(); // Update the event count
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to fetch event count.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Count'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _isLoading
                  ? const CircularProgressIndicator() // Show loading spinner while fetching data
                  : Text(
                      _eventCount.isNotEmpty
                          ? 'Open Event Count: $_eventCount'
                          : _errorMessage.isNotEmpty
                              ? _errorMessage
                              : 'Press the button to fetch event count',
                      style: const TextStyle(fontSize: 20),
                    ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _getEventCount,
                child: const Text('Fetch Event Count'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
