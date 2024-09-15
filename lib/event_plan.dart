import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'frappecall/form_info_data.dart'; // Adjust if the path is different
import 'main/pagebar.dart'; 
import 'innerpages/document.dart';
import 'innerpages/form_info.dart';

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

  Future<void> loadEvents() async {
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
        print('Error fetching events: $e');
      }
      setState(() {
        isLoading = false;
        errorMessage = 'Failed to load events. Please check your connection and try again.';
      });
    }
  }

  Widget buildRetryButton() {
    return ElevatedButton(
      onPressed: loadEvents,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF6e60fe),
      ),
      child: const Text('Retry'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      body: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const EventFormPage()),
            );
          },
          backgroundColor: const Color(0xFF6e60fe),
          child: const Icon(Icons.add, color: Colors.white),
        ),
        appBar: AppBar(
          title: const Text(
            'Event Planning',
            style: TextStyle(
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
                ? buildErrorState()
                : events.isEmpty
                    ? buildEmptyState()
                    : buildEventList(),
      ),
      selectedIndex: 1,
    );
  }

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

  Widget buildEventList() {
    return ListView.builder(
      itemCount: events.length,
      itemBuilder: (context, index) {
        final event = events[index];
        return GestureDetector(
          onTap: () {
            print('Tapped event: ${event['name']}'); // Debug statement
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FormInfo(event: event),
              ),
            ).then((_) {
              print('Returned from FormInfo'); // Debug statement
            });
          },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              title: Text(
                event['name'] ?? 'Unnamed Event',
                style: const TextStyle(
                  color: Color(0xFF6e60fe),
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '${event['customer'] ?? 'No customer'}',
                      style: const TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: ' - ${event['creation'] ?? 'Unknown Date'}',
                      style: const TextStyle(
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
