import 'package:flutter/material.dart';
import 'main/pagebar.dart'; // Ensure this path is correct
import 'login.dart'; // Ensure this import is correct

class AccountInfo extends StatefulWidget {
  final String fullName; // Field to hold the user's full name

  const AccountInfo({Key? key, required this.fullName}) : super(key: key);

  @override
  State<AccountInfo> createState() => _AccountInfoState();
}

class _AccountInfoState extends State<AccountInfo> {
  void _logout() {
    // Navigate back to the LoginUI
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginUI()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      selectedIndex: 3, // Ensure MainScaffold properly uses this index
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
          backgroundColor: Colors.white,
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView( // Make the content scrollable
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 50, // Adjust the size of the profile picture
                      backgroundColor: Color.fromARGB(255, 245, 245, 255), // Placeholder color
                      child: Icon(Icons.person, color: Colors.black), // Placeholder icon
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.fullName, // Use widget.fullName to display the user's full name
                      style: const TextStyle(
                        color: Color(0xFF6e60fe),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20), // Space before the button
                    ElevatedButton(
                      onPressed: _logout,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6e60fe), // Button color
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      child: const Text(
                        'Logout',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "About Us",
                      style: TextStyle(
                        color: Color(0xFF6e60fe),
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Image.asset(
                      'images/about.png', // Ensure this path is correct and image is added in pubspec.yaml
                      width: double.infinity, // Image takes full width
                      height: 200, // Adjust the height as needed
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 15),
                    RichText(
                      text: const TextSpan(
                        text: 'Ex Event Planning is one of the newest and most innovative event planning solutions, designed to streamline the organization of corporate events, trade shows, and conferences. For more information, visit our website at ',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey, // Default color for the text
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'www.erpxpand.com',
                            style: TextStyle(
                              fontWeight: FontWeight.bold, // Bold for the website part
                              color: Color(0xFF6e60fe), // Optional: Change the color of the link
                            ),
                          ),
                          TextSpan(
                            text: '.',
                            style: TextStyle(
                              color: Colors.grey, // Continue the default style after the link
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
