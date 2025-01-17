import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fyp2/firebase/model.dart';

class FireStoreService{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //Create a collection, bind data with specific uid and add food data into FireStore
  Future<void> addFoodEntry({
    required String userId,
    required String imagePath,
    required String foodName,
    required String calories
}) async{
    try{
      final foodEntry = FoodEntry(
          imagePath: imagePath,
          foodName: foodName,
          calories: calories,
      );

      await _firestore
      .collection('FoodData')
      .doc(userId)
      .collection('foodEntries')
      .add(foodEntry.toMap());
    }on FirebaseException catch(e){
      throw Exception('Failed to save food entry: ${e.message}');
    }
  }


  //Fetch food data from FireStore and display
  Stream<QuerySnapshot> getFoodEntries(String userId){
    return _firestore
        .collection('FoodData')
        .doc(userId)
        .collection('foodEntries')
        .snapshots();
  }

  //Update food data(optional)
  Future<void> updateFoodData(String imagePath, String foodName, String calories) async{}

  //Delete food data for specific uid
  Future<void> deleteFoodEntry(String userId, String entryId) async{
    try{
      await _firestore
          .collection('FoodData')
          .doc(userId)
          .collection('foodEntries')
          .doc(entryId)
          .delete();
    }catch(e){
      throw Exception('Failed to delete food entry: $e');
    }
  }
}