import 'package:flutter/material.dart';
import 'frappecall/open_docs_count.dart'; 
import 'frappecall/completed_doc_count.dart'; 
import 'frappecall/cancelled_doc_count.dart'; 
import 'frappecall/rescheduled_doc_count.dart';

void main() async {
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
  int _openBookings = 0; // State to hold the open bookings count
  int _completedBookings = 0; // State to hold the completed bookings count
  int _cancelledBookings = 0;
  int _rescheduledBookings = 0;
  bool _isLoading = false; // Loading state
  String _errorMessage = ''; // Error message

  @override
  void initState() {
    super.initState();
    _fetchOpenBookingsCount(); // Fetch open bookings when the widget is initialized
    _fetchCompletedBookingsCount(); // Fetch completed bookings when the widget is initialized
    _fetchCancelledEventCount();
    _fetchRescheduleEventCount();
  }

// ***************Functions calling API's******************
  Future<void> _fetchOpenBookingsCount() async {
    setState(() {
      _isLoading = true; // Start loading
      _errorMessage = ''; // Clear any previous errors
    });

    try {
      int count = await fetchOpenEventCount(); // Fetch the count from the API
      setState(() {
        _openBookings = count; // Update the count in the state
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to fetch open bookings count'; // Update error message
      });
    } finally {
      setState(() {
        _isLoading = false; // Stop loading
      });
    }
  }

  Future<void> _fetchCompletedBookingsCount() async {
    setState(() {
      _isLoading = true; // Start loading
      _errorMessage = ''; // Clear any previous errors
    });

    try {
      int count = await fetchCompletedEventCount(); // Fetch the completed count from the API
      setState(() {
        _completedBookings = count; // Update the count in the state
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to fetch completed bookings count'; // Update error message
      });
    } finally {
      setState(() {
        _isLoading = false; // Stop loading
      });
    }
  }

  Future<void> _fetchCancelledEventCount() async {
    setState(() {
      _isLoading = true; // Start loading
      _errorMessage = ''; // Clear any previous errors
    });

    try {
      int count = await fetchCancelledEventCount(); // Fetch the completed count from the API
      setState(() {
        _cancelledBookings = count; // Update the count in the state
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to fetch completed bookings count'; // Update error message
      });
    } finally {
      setState(() {
        _isLoading = false; // Stop loading
      });
    }
  }

  Future<void> _fetchRescheduleEventCount() async {
    setState(() {
      _isLoading = true; // Start loading
      _errorMessage = ''; // Clear any previous errors
    });

    try {
      int count = await fetchRescheduleEventCount(); // Fetch the completed count from the API
      setState(() {
        _rescheduledBookings = count; // Update the count in the state
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to fetch completed bookings count'; // Update error message
      });
    } finally {
      setState(() {
        _isLoading = false; // Stop loading
      });
    }
  }


// **************MAIN BUILD*****************
  @override
  Widget build(BuildContext context) {
    var exLogo = const Text(
      "Ex Event Planning",
      style: TextStyle(
        color: Color(0xFF6e60fe),
        fontSize: 40,
        fontWeight: FontWeight.bold,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home',
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: SizedBox(
                height: 80,
                width: 80,
                child: Image.asset(
                  'images/ex_logo.jpg',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          exLogo,
          const SizedBox(height: 30),

          // Cards Row with horizontal scrolling
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                cardWidget(
                  "Open Bookings",
                  _isLoading ? 0 : _openBookings,
                  Colors.red,
                ),
                cardWidget(
                  "Completed Bookings",
                  _isLoading ? 0 : _completedBookings, 
                  Colors.green,
                ),
                cardWidget(
                  "Cancelled Bookings",
                  _isLoading ? 0 : _cancelledBookings, 
                  Colors.orange,
                ),
                cardWidget(
                  "Rescheduled Bookings",
                  _isLoading ? 0 : _rescheduledBookings,
                  Colors.blue,
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),

          // Display error message if there's an issue fetching data
          if (_errorMessage.isNotEmpty)
            Text(
              _errorMessage,
              style: const TextStyle(color: Colors.red),
            ),

          // Column with rows of buttons
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Action for the first button
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6e60fe),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 42, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Ex Event Planning',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      // Action for the second button
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6e60fe),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 52, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Ex Event Task',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Action for the third button
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6e60fe),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 49, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Ex Daily Report',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      // Action for the fourth button
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6e60fe),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 46, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Ex Event Report',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget cardWidget(String title, int count, Color countColor) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 200,
        height: 90,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 2,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF6e60fe),
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                count.toString(),
                style: TextStyle(
                  color: countColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
