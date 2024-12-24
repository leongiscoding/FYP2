import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../firebase/firestore_service.dart';

class FoodEntryList extends StatelessWidget {
  final void Function(String entryId) onDelete;

  const FoodEntryList({Key? key, required this.onDelete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const Center(child: Text('Please login to view your food entries'));
    }

    return StreamBuilder<QuerySnapshot>(
      stream: FireStoreService().getFoodEntries(user.uid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final documents = snapshot.data?.docs ?? [];
        if (documents.isEmpty) {
          return Center(
            child: Text(
              'No food entries yet',
              style: GoogleFonts.dmSerifText(
                fontSize: 16,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.only(bottom: 80), // Add padding for the button
          itemCount: documents.length,
          itemBuilder: (context, index) {
            final doc = documents[index];
            final data = doc.data() as Map<String, dynamic>;

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                color: Theme.of(context).colorScheme.primary,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                      child: Image.file(
                        File(data['imagePath']),
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),

                    // Food info and delete button
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Food info
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Food: ${data['foodName']}',
                                  style: GoogleFonts.dmSerifText(
                                    fontSize: 18,
                                    color: Theme.of(context).colorScheme.inversePrimary,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Calories: ${data['calories']}',
                                  style: GoogleFonts.dmSerifText(
                                    fontSize: 16,
                                    color: Theme.of(context).colorScheme.inversePrimary,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Delete button
                          IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Theme.of(context).colorScheme.inversePrimary,
                            ),
                            onPressed: () => onDelete(doc.id),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
