import 'dart:convert';
import 'package:fake_store/product_screen.dart';
import 'package:http/http.dart' as http; // package for making API calls
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  late String _errorMessage = '';

  void _loginPressed() async {
    setState(() {
      _isLoading = true;
      _errorMessage;
    });

    // Send login request to API
    final response = await http.post(
      Uri.parse('https://fakestoreapi.com/auth/login'),
      body: jsonEncode({
        'username': _usernameController.text.trim(),
        'password': _passwordController.text.trim(),
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    setState(() {
      _isLoading = false;
    });

    // Check login response
    if (response.statusCode == 200) {
      // Login successful, navigate to product list screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ProductPage()),
      );
    } else {
      // Login failed, show error message
      setState(() {
        _errorMessage = 'Incorrect username or password';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "eCommerce",
              style: TextStyle(fontSize: 46, fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal),
                ),
                hintText: 'Username',
              ),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                hintText: 'Password',
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal),
                ),
              ),
              obscureText: true,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Forgot password?',
                      style: TextStyle(color: Colors.teal),
                    )),
              ],
            ),
            if (_errorMessage != null) // Show error message if there is one
              Text(
                _errorMessage,
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 43,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.teal,
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onPressed: _isLoading
                    ? null
                    : _loginPressed, // Disable button when loading
                child: _isLoading
                    ? CircularProgressIndicator() // Show loading indicator when loading
                    : Text('Log in'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
