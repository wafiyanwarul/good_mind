class NutritionData {
  final int calories;
  final double totalFat;
  final double saturatedFat;
  final double cholesterol;
  final double sodium;
  final double carbohydrates;
  final double fiber;
  final double sugars;
  final double protein;
  final double vitaminD;
  final double calcium;
  final double iron;
  final double potassium;

  NutritionData({
    required this.calories,
    required this.totalFat,
    required this.saturatedFat,
    required this.cholesterol,
    required this.sodium,
    required this.carbohydrates,
    required this.fiber,
    required this.sugars,
    required this.protein,
    required this.vitaminD,
    required this.calcium,
    required this.iron,
    required this.potassium,
  });

  factory NutritionData.fromJson(Map<String, dynamic>? json) {
  return NutritionData(
    calories: json?['calories'] ?? 0,
    totalFat: json?['totalNutrients']?['FAT']?['quantity'] ?? 0.0,
    saturatedFat: json?['totalNutrients']?['FASAT']?['quantity'] ?? 0.0,
    cholesterol: json?['totalNutrients']?['CHOLE']?['quantity'] ?? 0.0,
    sodium: json?['totalNutrients']?['NA']?['quantity'] ?? 0.0,
    carbohydrates: json?['totalNutrients']?['CHOCDF']?['quantity'] ?? 0.0,
    fiber: json?['totalNutrients']?['FIBTG']?['quantity'] ?? 0.0,
    sugars: json?['totalNutrients']?['SUGAR']?['quantity'] ?? 0.0,
    protein: json?['totalNutrients']?['PROCNT']?['quantity'] ?? 0.0,
    vitaminD: json?['totalNutrients']?['VITD']?['quantity'] ?? 0.0,
    calcium: json?['totalNutrients']?['CA']?['quantity'] ?? 0.0,
    iron: json?['totalNutrients']?['FE']?['quantity'] ?? 0.0,
    potassium: json?['totalNutrients']?['K']?['quantity'] ?? 0.0,
  );
}

}
