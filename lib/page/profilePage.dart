import 'package:flutter/material.dart';
import 'package:fyp2/component/profile_page/bmi_field.dart';
import 'package:fyp2/controller/bmi_calculator.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  double bmi = 0;
  String bmiCategory = "";

  void calculateAndShowBMI(){
    double height = double.tryParse(heightController.text) ?? 0;
    double weight = double.tryParse(weightController.text) ?? 0;

    if(height>0 && weight>0){
      setState(() {
        bmi = calculateBMI(height, weight);
        bmiCategory = getBMICategory(bmi);
      });
    }else{
      setState(() {
        bmi = 0;
        bmiCategory = "Invalid Input";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        title: const Text(
            "Profile",
          style: TextStyle(fontSize: 18),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body:  Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //DUMMY NAME, THIS SHOULD REFER TO FIREBASE AUTH DATA
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text("Name : Bob",style: TextStyle(fontSize: 30),),
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
                    child: const Text("Calculate BMI"),
                ),

                //SAVE TO DB
                ElevatedButton(
                  //THIS SHOULD SAVE bmi AND bmiCategory
                  onPressed: (){},
                  child: const Text("Save"),
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
                    style: const TextStyle(fontSize: 18),
                  ),
                  Text(
                    bmiCategory,
                    style: const TextStyle(fontSize: 18,color: Colors.black),
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
