import 'package:flutter/material.dart';
import 'frappecall/daily_report_list.dart'; // Import your API file
import 'main/pagebar.dart';

class DailyReport extends StatefulWidget {
  const DailyReport({super.key});

  @override
  DailyReportState createState() => DailyReportState();
}

class DailyReportState extends State<DailyReport> {
  DateTime? selectedDate;
  List<List<String>> apiData = []; // Placeholder for API data

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      selectedIndex: 2, // Set the selected index for the Daily Report
      body: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Daily Report',
            style: TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.white, // Consistent app color
        ),
        backgroundColor: const Color.fromARGB(255, 245, 245, 255),
        body: Column(
          children: [
            _buildDatePicker(),
            _buildDataTable(),
          ],
        ),
      ),
    );
  }

  /// Widget to build the Date Picker UI
  Widget _buildDatePicker() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          const Expanded(
            child: Text(
              'Select Date:',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
          ),
          TextButton(
            onPressed: () => _selectDate(context),
            child: Text(
              selectedDate != null
                  ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
                  : 'Select Date',
              style: const TextStyle(
                fontSize: 18,
                color: Color(0xFF6e60fe),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Widget to build the Data Table UI
  Widget _buildDataTable() {
    return Expanded(
      child: apiData.isEmpty
          ? const Center(
              child: Text(
                'No data available',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18,
                ),
              ),
            )
          : SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(
                    label: Text(
                      'Customer',
                      style: TextStyle(
                        color: Color(0xFF6e60fe),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Begins On',
                      style: TextStyle(
                        color: Color(0xFF6e60fe),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Ends On',
                      style: TextStyle(
                        color: Color(0xFF6e60fe),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Event Location',
                      style: TextStyle(
                        color: Color(0xFF6e60fe),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Event Category',
                      style: TextStyle(
                        color: Color(0xFF6e60fe),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'No. of Guests',
                      style: TextStyle(
                        color: Color(0xFF6e60fe),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Product Bundles',
                      style: TextStyle(
                        color: Color(0xFF6e60fe),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
                rows: apiData.map((row) {
                  return DataRow(
                    cells: row.map((cell) => DataCell(Text(cell))).toList(),
                  );
                }).toList(),
              ),
            ),
    );
  }

  /// Method to open date picker and fetch events based on the selected date
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _fetchEvents(); // Fetch events after selecting the date
      });
    }
  }

  /// Method to fetch events from the API
  Future<void> _fetchEvents() async {
    try {
      final events = await fetchEvents();
      setState(() {
        apiData = _filterAndFormatEventData(events);
      });
    } catch (e) {
      // Handle errors (e.g., log or show a message to the user)
      logger.e('Error fetching events', error: e);
    }
  }

  /// Helper method to filter and format API data into a List of Lists for the DataTable
  List<List<String>> _filterAndFormatEventData(List<Map<String, dynamic>> events) {
    if (selectedDate == null) {
      return []; // Return an empty list if no date is selected
    }

    final filteredEvents = events.where((event) {
      final beginsOn = DateTime.tryParse(event['begins_on'] ?? '');
      final endsOn = DateTime.tryParse(event['ends_on'] ?? '');
      return beginsOn != null && endsOn != null &&
             selectedDate!.isAfter(beginsOn.subtract(const Duration(days: 1))) &&
             selectedDate!.isBefore(endsOn.add(const Duration(days: 1)));
    }).toList();

    return filteredEvents.map((event) {
      return [
        event['customer']?.toString() ?? '',
        event['begins_on']?.toString() ?? '',
        event['ends_on']?.toString() ?? '',
        event['event_location']?.toString() ?? '',
        event['event_type']?.toString() ?? '',
        event['expected_no_of_guest']?.toString() ?? '',
        event['product_bundles']?.toString() ?? '',
      ];
    }).toList();
  }
}
