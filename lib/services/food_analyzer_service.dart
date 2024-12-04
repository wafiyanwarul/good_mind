import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/nutrition_data.dart';
import '../models/daily_values.dart';
import '../models/ingredient.dart';

class FoodAnalyzerService {
  Future<Map<String, dynamic>> analyzeRecipe(String title, String ingredients) async {
    final response = await http.get(
      Uri.parse(
          'https://api.edamam.com/api/nutrition-data?app_id=YOUR_APP_ID&app_key=YOUR_APP_KEY&title=$title&ingr=$ingredients'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return {
        "nutritionData": NutritionData.fromJson(data),
        "dailyValues": DailyValues.fromJson(data["totalDaily"]),
        "ingredientsData": (data["ingredients"] as List).map((item) => Ingredient.fromJson(item)).toList(),
      };
    } else {
      throw Exception('Failed to fetch data from API');
    }
  }
}
