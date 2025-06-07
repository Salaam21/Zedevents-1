import 'package:flutter/material.dart';

class CreateEventScreen extends StatelessWidget {
  const CreateEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Event')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView( // Important for handling keyboard input
          child: Column(
            children: [
              TextFormField(decoration: InputDecoration(labelText: 'Event Title')),
              TextFormField(decoration: InputDecoration(labelText: 'Description')),
              // ... other form fields (date, time, location, etc.)
              ElevatedButton(
                onPressed: () {
                  // Handle event creation
                },
                child: Text('Create Event'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}