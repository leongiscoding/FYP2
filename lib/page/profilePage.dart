import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp2/component/profile_page/bmi_field.dart';
import 'package:fyp2/controller/bmi_calculator.dart';
import 'package:fyp2/firebase/firestore_service.dart';
import 'package:fyp2/firebase/profile_firestore_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  //Get current/registered username
  User? user = FirebaseAuth.instance.currentUser;
  final ProfileFireStoreService _fireStoreService = ProfileFireStoreService();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  double bmi = 0;
  String bmiCategory = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadBMIFromFireStore();
  }

  // Load BMI and Category from Shared Preferences
  Future<void> loadBMIFromFireStore() async {
    try {
      final data = await _fireStoreService.loadBMIFromFireStore();
      if (data != null) {
        setState(() {
          bmi = data['bmi'] ?? 0;
          bmiCategory = data['bmiCategory'] ?? "No BMI Calculated";
          heightController.text = data['height']?.toString() ?? '';
          weightController.text = data['weight']?.toString() ?? '';
        });
      } else {
        setState(() {
          bmi = 0;
          bmiCategory = "No Data Found";
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error loading BMI data: $e")),
      );
    }
  }




  // call calculation from bmi_calculator.dart
  Future<void> saveBMIToFireStore() async{
    double height = double.tryParse(heightController.text) ?? 0;
    double weight = double.tryParse(weightController.text) ?? 0;

    if(height>0 && weight>0){
      setState(() {
        bmi = calculateBMI(height, weight);
        bmiCategory = getBMICategory(bmi);
      });
      await _fireStoreService.saveBMIToFireStore(
          height: height,
          weight: weight,
          bmi: bmi,
          bmiCategory: bmiCategory
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Saved Successfully"),duration: Duration(seconds: 1),)
      );
    }else{
      setState(() {
        bmi = 0;
        bmiCategory = "Invalid Input";
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to Save Data"),duration: Duration(seconds: 1),)
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        title:  Text(
            "Profile",
          style: GoogleFonts.dmSerifText(
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),

      body:  Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Username information
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                // read username from firebase
                "Name: ${user?.displayName ?? 'User unknown'}",
                style: GoogleFonts.dmSerifText(
                  fontSize: 18,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),

            //Email Information
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                //read email from firebase
               "Email: ${FirebaseAuth.instance.currentUser!.email!.toString()}",
                style: GoogleFonts.dmSerifText(
                  fontSize: 18,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),

            //BMI FIELD FOR HEIGHT AND WEIGHT
            BMIField(
                labelText: "Height (m)",
                hintText: "Ex: 178 -> 1.78",
                controller: heightController,
            ),

            BMIField(
                labelText: "Weight (kg)",
                controller: weightController,
                hintText: "Ex: 60kg"
            ),
            SizedBox(height: 20,),

            //BUTTON
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                //CALCULATE BMI and Save
                ElevatedButton(
                    onPressed: saveBMIToFireStore,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Theme.of(context).colorScheme.inversePrimary,
                    ),
                    child: Text(
                        "Calculate and Save BMI",
                      style: GoogleFonts.dmSerifText(
                        fontSize: 14,
                      ),
                    ),
                ),
              ],
            ),
            SizedBox(height: 20,),

            //DISPLAY BMI RESULTS
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "BMI: ${bmi > 0 ? bmi.toStringAsFixed(1): 'Not Calculated'}",
                    style:  GoogleFonts.dmSerifText(
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  Text(
                    bmiCategory.isNotEmpty ? bmiCategory: 'No BMI Category',
                    style:  GoogleFonts.dmSerifText(
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
