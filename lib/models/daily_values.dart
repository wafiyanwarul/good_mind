class DailyValues {
  final double totalFat;
  final double saturatedFat;
  final double cholesterol;
  final double sodium;
  final double carbohydrates;
  final double fiber;
  final double protein;
  final double vitaminD;
  final double calcium;
  final double iron;
  final double potassium;

  DailyValues({
    required this.totalFat,
    required this.saturatedFat,
    required this.cholesterol,
    required this.sodium,
    required this.carbohydrates,
    required this.fiber,
    required this.protein,
    required this.vitaminD,
    required this.calcium,
    required this.iron,
    required this.potassium,
  });

  factory DailyValues.fromJson(Map<String, dynamic>? json) {
  return DailyValues(
    totalFat: json?['FAT']?['quantity'] ?? 0.0,
    saturatedFat: json?['FASAT']?['quantity'] ?? 0.0,
    cholesterol: json?['CHOLE']?['quantity'] ?? 0.0,
    sodium: json?['NA']?['quantity'] ?? 0.0,
    carbohydrates: json?['CHOCDF']?['quantity'] ?? 0.0,
    fiber: json?['FIBTG']?['quantity'] ?? 0.0,
    protein: json?['PROCNT']?['quantity'] ?? 0.0,
    vitaminD: json?['VITD']?['quantity'] ?? 0.0,
    calcium: json?['CA']?['quantity'] ?? 0.0,
    iron: json?['FE']?['quantity'] ?? 0.0,
    potassium: json?['K']?['quantity'] ?? 0.0,
  );
}

}
