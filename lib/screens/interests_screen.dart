import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InterestsScreen extends StatefulWidget {
  const InterestsScreen({super.key});

  @override
  _InterestsScreenState createState() => _InterestsScreenState();
}

class _InterestsScreenState extends State<InterestsScreen> {
  List<String> interests = [
    'Music Concerts',
    'Live Music',
    'Festivals',
    'Movies',
    'Theater',
    'Comedy Shows',
    'Sports Events',
    'Football',
    'Basketball',
    'MMA',
    'Motor Shows',
    'Art Exhibitions',
    'House Parties',
    'Galas',
    'Food Festivals',
    'Wine Tastings',
    'Cooking Classes',
    'Travel',
    'Technology',
    'Fashion',
    'Gaming',
  ];
  List<String> selectedInterests = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.deepPurple.shade800, Colors.purple.shade200],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'What do you want to see on Zed Events?',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 16),
              Expanded(
                child: Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  alignment: WrapAlignment.center,
                  children: interests.map((interest) {
                    return ChoiceChip(
                      label: Text(
                        interest,
                        style: TextStyle(color: const Color.fromARGB(255, 15, 11, 11)),
                      ),
                      selectedColor: Colors.deepPurple,
                      selected: selectedInterests.contains(interest),
                      onSelected: (bool isSelected) { // Corrected onSelected callback
                        setState(() {
                          if (isSelected) {
                            selectedInterests.add(interest);
                          } else {
                            selectedInterests.remove(interest);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: selectedInterests.isNotEmpty
                      ? () async {
                          final prefs = await SharedPreferences.getInstance();
                          prefs.setStringList('selectedInterests', selectedInterests);

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  HomeScreen(selectedInterests: selectedInterests),
                            ),
                          );
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.deepPurple,
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