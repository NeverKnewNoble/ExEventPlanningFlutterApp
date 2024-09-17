import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'main.dart'; // Import the main.dart file to access FrontPage
import 'frappecall/login_post_call.dart'; // Import the API call function

class LoginUI extends StatefulWidget {
  const LoginUI({super.key});

  @override
  LoginUIState createState() => LoginUIState();
}

class LoginUIState extends State<LoginUI> {
  final _formKey = GlobalKey<FormState>();
  String? _email; // Changed to String? to handle null values
  String? _password; // Changed to String? to handle null values
  bool _isLoading = false; // To show loading indicator during API call

  // Function to handle the login process
  Future<void> _login() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      setState(() {
        _isLoading = true;
      });

      try {
        // Call the API
        final response = await verifyLogin(_email!, _password!);

        setState(() {
          _isLoading = false;
        });

        // Check if the widget is still mounted before navigating
        if (!mounted) return;

        // Access the "data" field in the response
        if (response['data']['status'] == 'success') {
          // Navigate to FrontPage on successful login
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const FrontPage()),
          );
        } else {
          // Show an error message if login fails
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(response['data']['message'] ?? 'Login failed')),
          );
        }
      } catch (e) {
        setState(() {
          _isLoading = false;
        });

        // Check if the widget is still mounted before showing a SnackBar
        if (!mounted) return;

        // Handle network or other errors
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Something went wrong. Please try again.')),
        );
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login',
          style: TextStyle(
            color: Color(0xFF6e60fe),
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center the content vertically
            children: [
              Image.asset(
                'images/login.png', // Ensure this path is correct and image is added in pubspec.yaml
                width: 400, // Image takes full width
                height: 300, // Adjust the height as needed
              ),
              const SizedBox(height: 15),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  filled: true, // Enables the background color
                  fillColor: const Color.fromARGB(255, 245, 245, 255), // Background color of the field
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0), // Rounded corners
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0), // Rounded corners
                    borderSide: const BorderSide(color: Color.fromARGB(255, 245, 245, 255), width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0), // Rounded corners
                    borderSide: const BorderSide(color: Color(0xFF6e60fe), width: 2.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email';
                  }
                  if (!EmailValidator.validate(value)) {
                    return 'Enter a valid email';
                  }
                  return null;
                },
                onSaved: (value) => _email = value,
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  filled: true, // Enables the background color
                  fillColor: const Color.fromARGB(255, 245, 245, 255), // Background color of the field
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0), // Rounded corners
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0), // Rounded corners
                    borderSide: const BorderSide(color: Color.fromARGB(255, 245, 245, 255), width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0), // Rounded corners
                    borderSide: const BorderSide(color: Color(0xFF6e60fe), width: 2.0),
                  ),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.length < 8) {
                    return 'Please enter a password with at least 8 characters';
                  }
                  return null;
                },
                onSaved: (value) => _password = value,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity, // Set width to fill the available space
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color(0xFF6e60fe), // Text color of the button
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0), // Rounded corners
                    ),
                  ),
                  onPressed: _isLoading ? null : _login, // Disable button if loading
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
