import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart'; // Import your welcome screen

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zed Events',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: WelcomeScreen(), // Set WelcomeScreen as the initial route
    );
  }
}