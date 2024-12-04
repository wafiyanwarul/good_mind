class Ingredient {
  final double quantity;
  final String unit;
  final String food;
  final double calories;
  final double weight;

  Ingredient({
    required this.quantity,
    required this.unit,
    required this.food,
    required this.calories,
    required this.weight,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      quantity: json['parsed'][0]['quantity'] ?? 0.0,
      unit: json['parsed'][0]['measure'] ?? "unknown",
      food: json['parsed'][0]['food'] ?? "unknown",
      calories: json['parsed'][0]['nutrients']['ENERC_KCAL']['quantity'] ?? 0.0,
      weight: json['parsed'][0]['weight'] ?? 0.0,
    );
  }
}
