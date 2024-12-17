import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp2/component/profile_page/bmi_field.dart';
import 'package:fyp2/controller/bmi_calculator.dart';
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

  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  double bmi = 0;
  String bmiCategory = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadBMIFromSharedPreferences();
  }

  // Load BMI and Category from Shared Preferences
  Future<void> loadBMIFromSharedPreferences() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      bmi = prefs.getDouble('bmi') ?? 0;
      bmiCategory = prefs.getString('bmiCategory') ?? "No BMI Calculated";
      heightController.text = prefs.getString('height') ?? '';
      weightController.text = prefs.getString('weight') ?? '';
    });
  }

  //Save BMI and Category to Shared Preferences
  Future<void> saveBMIToSharedPreferences() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('bmi', bmi);
    await prefs.setString('bmiCategory', bmiCategory);
    await prefs.setString('height', heightController.text);
    await prefs.setString('weight', weightController.text);
  }

  // call calculation from bmi_calculator.dart
  Future<void> calculateAndShowBMI() async{
    double height = double.tryParse(heightController.text) ?? 0;
    double weight = double.tryParse(weightController.text) ?? 0;

    if(height>0 && weight>0){
      setState(() {
        bmi = calculateBMI(height, weight);
        bmiCategory = getBMICategory(bmi);
      });
      await saveBMIToSharedPreferences();
    }else{
      setState(() {
        bmi = 0;
        bmiCategory = "Invalid Input";
      });
      await saveBMIToSharedPreferences();
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
                //CALCULATE BMI
                ElevatedButton(
                    onPressed: calculateAndShowBMI,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Theme.of(context).colorScheme.inversePrimary,
                    ),
                    child: Text(
                        "Calculate BMI",
                      style: GoogleFonts.dmSerifText(
                        fontSize: 14,
                      ),
                    ),
                ),

                //SAVE TO DB
                ElevatedButton(
                  //THIS SHOULD SAVE bmi AND bmiCategory
                  onPressed: (){},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.inversePrimary,
                  ),
                  child: Text(
                      "Save",
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
                    "BMI: ${bmi.toStringAsFixed(1)}",
                    style:  GoogleFonts.dmSerifText(
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  Text(
                    bmiCategory,
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
