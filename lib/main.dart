import 'package:fake_store/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // package for making API calls
import 'dart:convert';

import 'login_screen.dart'; // package for decoding JSON responses

// username: "mor_2314",
// password: "83r5^_"
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Product App',
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        // show the SplashScreen initially
        routes: {
          '/home': (context) => LoginPage(),
        });
  }
}

// Login page widget
