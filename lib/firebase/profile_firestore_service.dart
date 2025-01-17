import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileFireStoreService{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String userId = FirebaseAuth.instance.currentUser!.uid;

  Future<void> saveBMIToFireStore({
    required double height,
    required double weight,
    required double bmi,
    required String bmiCategory,
})async{
  await _firestore
  .collection('FoodData')
  .doc(userId)
  .collection('profile')
  .doc('bmiData')
  .set({
    'height':height,
    'weight':weight,
    'bmi':bmi,
    'bmiCategory':bmiCategory
  },SetOptions(merge: true));
  }

  Future<Map<String, dynamic>?> loadBMIFromFireStore() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        DocumentSnapshot snapshot = await _firestore
            .collection('FoodData')
            .doc(userId)
            .collection('profile')
            .doc('bmiData')
            .get();

        if (snapshot.exists) {
          return snapshot.data() as Map<String, dynamic>;
        }
      }
      return null;
    } catch (e) {
      print("Error fetching BMI data: $e");
      return null;
    }
  }

}