import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResultPage extends StatelessWidget {
  final String imagePath;
  final String fruitName;
  final String calories;

  const ResultPage({
    super.key,
    required this.imagePath,
    required this.fruitName,
    required this.calories,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.secondary,
        backgroundColor: Colors.transparent,
        title:  Text(
          "Results",
          style: GoogleFonts.dmSerifText(
            textStyle: TextStyle(
                color: Theme.of(context).colorScheme.secondary
            ),
          ),
        ),
      ),

      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Card(
              color: Theme.of(context).colorScheme.primary,
              elevation: 8, // Shadow depth of the card
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20), // Rounded corners
              ),
              margin: const EdgeInsets.symmetric(horizontal: 16.0), // Side margins for card
              child: Padding(
                padding: const EdgeInsets.all(20.0), // Padding inside the card
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Minimize the card's height
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16.0), // Round image corners
                      child: Image.file(
                        File(imagePath),
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 20),

                    Text(
                      'Fruit: $fruitName',
                      style: GoogleFonts.dmSerifText(
                        textStyle: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),

                    Text(
                      'Calories: $calories',
                      style: GoogleFonts.dmSerifText(
                        textStyle: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20), // Space between card and button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 4,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.inversePrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16), // Rounded button
                ),
              ),
              onPressed: () {
                // IMPLEMENT LOGIC FOR SAVE INFORMATION
              },
              child: Text(
                "Save Information",
                style: GoogleFonts.dmSerifText(
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
