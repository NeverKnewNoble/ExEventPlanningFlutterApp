import 'package:flutter/material.dart';
import 'frappecall/open_docs_count.dart';
import 'frappecall/completed_doc_count.dart';
import 'frappecall/cancelled_doc_count.dart';
import 'frappecall/rescheduled_doc_count.dart';
import 'main/pagebar.dart';
import 'main/card_widget.dart'; // Include your card widget file here

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: FrontPage(),
  ));
}

class FrontPage extends StatefulWidget {
  const FrontPage({super.key});

  @override
  FrontPageState createState() => FrontPageState();
}

class FrontPageState extends State<FrontPage> {
  int _openBookings = 0;
  int _completedBookings = 0;
  int _cancelledBookings = 0;
  int _rescheduledBookings = 0;
  bool _isLoading = false;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchCounts();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _fetchCounts() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final openCount = await fetchOpenEventCount();
      final completedCount = await fetchCompletedEventCount();
      final cancelledCount = await fetchCancelledEventCount();
      final rescheduledCount = await fetchRescheduleEventCount();

      // Check if the widget is still mounted before updating the state
      if (!mounted) return;

      setState(() {
        _openBookings = openCount;
        _completedBookings = completedCount;
        _cancelledBookings = cancelledCount;
        _rescheduledBookings = rescheduledCount;
      });
    } catch (e) {
      if (!mounted) return; // Ensure the widget is mounted

      setState(() {
        _errorMessage = 'Failed to fetch booking counts. Please try again.';
      });
    } finally {
      // ignore: control_flow_in_finally
      if (!mounted) return; // Ensure the widget is mounted

      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const exLogo = Align(
      alignment: Alignment.topLeft,
      child: Text(
        "Welcome",
        style: TextStyle(
          color: Color(0xFF6e60fe),
          fontSize: 40,
          fontWeight: FontWeight.bold,
        ),
      ),
    );

    return MainScaffold(
      selectedIndex: 0, // Set index for Home (FrontPage)
      body: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Ex Event Planner',
            style: TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              exLogo,
              const SizedBox(height: 30),
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Expanded(
                      child: GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 16,
                        childAspectRatio: 1.5,
                        children: [
                          cardWidget("Open", _openBookings, const Color(0xFF6e60fe)),
                          cardWidget("Completed", _completedBookings, const Color(0xFF6e60fe)),
                          cardWidget("Cancelled", _cancelledBookings, const Color(0xFF6e60fe)),
                          cardWidget("Rescheduled", _rescheduledBookings, const Color(0xFF6e60fe)),
                        ],
                      ),
                    ),
              if (_errorMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    _errorMessage,
                    style: const TextStyle(color: Colors.red, fontSize: 16),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
