import 'package:flutter/material.dart';
import 'main/pagebar.dart'; 

class DailyReport extends StatefulWidget {
  const DailyReport({super.key});

  @override
  DailyReportState createState() => DailyReportState();
}

class DailyReportState extends State<DailyReport> {
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
        backgroundColor: Colors.white,
        body: const Center(
          child: Text(
            'No reports available',
            style: TextStyle(
              color: Colors.black54,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
