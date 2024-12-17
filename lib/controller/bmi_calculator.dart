import 'package:shared_preferences/shared_preferences.dart';

double calculateBMI(double height, double weight){
  return weight/(height * height);
}

String getBMICategory(double bmi) {
  if (bmi <= 18.5) {
    return "Eat more food";
  } else if (bmi > 18.5 && bmi <= 24.9) {
    return "You have a healthy body";
  } else if (bmi > 24.9 && bmi <= 29.9) {
    return "Do some exercise";
  } else {
    return "Please lose your weight or \nmake an appointment with doctor";
  }
}

Future<void> saveBMIResults(double bmi, String category) async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setDouble('bmi', bmi);
  await prefs.setString('bmiCategory', category);
}

Future<String> getSavedBMICategory() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('bmiCategory') ?? 'No Data';
}

Future<void> calculateAndSaveBMI(double height, double weight) async{
  double bmi = calculateBMI(height, weight);
  String category = getBMICategory(bmi);
  await saveBMIResults(bmi, category);
}