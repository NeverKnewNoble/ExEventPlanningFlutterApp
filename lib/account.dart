import 'package:flutter/material.dart';
import 'main/pagebar.dart'; 

class AccountInfo extends StatefulWidget {
  const AccountInfo({super.key});

  @override
  AccountInfoState createState() => AccountInfoState();
}

class AccountInfoState extends State<AccountInfo> {
  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      selectedIndex: 3, // Set the selected index for the Daily Report
      body: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Account',
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
            'No Account Info',
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
