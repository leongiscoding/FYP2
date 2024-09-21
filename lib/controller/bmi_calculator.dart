
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
    return "Please lose your weight";
  }
}