import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'frappecall/listview.dart'; 
import 'main/pagebar.dart'; 

class EventPlan extends StatefulWidget {
  const EventPlan({super.key});

  @override
  EventPlanState createState() => EventPlanState();
}

class EventPlanState extends State<EventPlan> {
  List events = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    loadEvents();
  }

  loadEvents() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      List fetchedEvents = await fetchEvents();
      setState(() {
        events = fetchedEvents;
        isLoading = false;
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      setState(() {
        isLoading = false;
        errorMessage = 'Failed to load events. Please try again.';
      });
    }
  }

  // Widget for retry button (to avoid redundancy)
  Widget buildRetryButton() {
    return ElevatedButton(
      onPressed: loadEvents,
      child: const Text('Retry'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      body: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Event Planning',
            style: TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.white, // Consistent app color
        ),
        backgroundColor: Colors.white,
        body: isLoading
            ? const Center(child: CircularProgressIndicator()) // Loading state
            : errorMessage != null
                ? buildErrorState() // Error handling state
                : events.isEmpty
                    ? buildEmptyState() // Empty list state
                    : buildEventList(), // Display the list of events
      ),
      selectedIndex: 1, // Set the selected index for Event Planning
    );
  }

  // Widget for error state UI
  Widget buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            errorMessage!,
            style: const TextStyle(color: Colors.red, fontSize: 16),
          ),
          const SizedBox(height: 10),
          buildRetryButton(),
        ],
      ),
    );
  }

  // Widget for empty state UI
  Widget buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('No events found', style: TextStyle(fontSize: 16)),
          const SizedBox(height: 10),
          buildRetryButton(),
        ],
      ),
    );
  }

  // Widget to build the event list UI
  Widget buildEventList() {
    return ListView.builder(
      itemCount: events.length,
      itemBuilder: (context, index) {
        final event = events[index];
        return ListTile(
          title: Text(event['name'] ?? 'Unnamed Event'),
          subtitle: Text(event['creation'] ?? 'Unknown Date'),
        );
      },
    );
  }
}
