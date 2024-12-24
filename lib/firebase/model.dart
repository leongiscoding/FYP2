class FoodEntry{
  final String imagePath;
  final String foodName;
  final String calories;

  FoodEntry({
    required this.imagePath,
    required this.foodName,
    required this.calories,
});

  Map<String,dynamic> toMap(){
    return {
      'imagePath': imagePath,
      'foodName': foodName,
      'calories': calories,
    };
  }

  factory FoodEntry.fromMap(Map<String, dynamic> map){
    return FoodEntry(
        imagePath: map['imagePath'] ?? '',
        foodName: map['foodName'] ?? '',
        calories: map['calories'] ?? '0.0',
    );
  }
}