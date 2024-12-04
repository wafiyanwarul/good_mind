import 'package:flutter/material.dart';
import 'package:good_mind/models/daily_values.dart';
import 'package:good_mind/models/ingredient.dart';
import 'package:good_mind/models/nutrition_data.dart';
import 'package:good_mind/services/food_analyzer_service.dart';
import 'package:good_mind/theme/app_theme.dart';
import 'package:good_mind/widgets/nutrition_row.dart';
import 'package:google_fonts/google_fonts.dart';

class SingleFoodAnalyzerScreen extends StatefulWidget {
  const SingleFoodAnalyzerScreen({super.key});

  @override
  State<SingleFoodAnalyzerScreen> createState() =>
      _SingleFoodAnalyzerScreenState();
}

class _SingleFoodAnalyzerScreenState extends State<SingleFoodAnalyzerScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController ingredientsController = TextEditingController();

  NutritionData? nutritionData;
  DailyValues? dailyValues;
  List<Ingredient>? ingredientsData;

  Future<void> analyzeRecipe() async {
    try {
      final result = await FoodAnalyzerService().analyzeRecipe(
        titleController.text,
        ingredientsController.text,
      );
      setState(() {
        nutritionData = result["nutritionData"] as NutritionData;
        dailyValues = result["dailyValues"] as DailyValues;
        ingredientsData = result["ingredientsData"] as List<Ingredient>;
      });
    } catch (e) {
      // print("Error analyzing recipe: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipe Analyzer', style: appbarHeadingStyle),
        backgroundColor: secondColor,
        centerTitle: true,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
      ),
      body: ListView(children: [
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Recipe Title",
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: secondColor,
                ),
              ),
              const SizedBox(height: 10),
              // Title TextField
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: "Enter Recipe Title",
                  hintStyle: GoogleFonts.plusJakartaSans(
                    color: secondColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                ),
              ),
              const SizedBox(height: 15),
              Text(
                "Recipe Description",
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: secondColor,
                ),
              ),
              const SizedBox(height: 10),
              // Ingredients TextField
              SizedBox(
                height: 60, // Tinggi tetap 120
                child: TextFormField(
                  controller: ingredientsController,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: "Enter Recipe Detail Here",
                    hintStyle: GoogleFonts.plusJakartaSans(
                      color: secondColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                  ),
                  // Menambahkan scrollable behavior
                  scrollPhysics: const BouncingScrollPhysics(),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity, // Lebar penuh sesuai ukuran parent
                height: 50, // Tinggi tombol
                child: TextButton(
                  onPressed: analyzeRecipe,
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.resolveWith<Color>((states) {
                      if (states.contains(WidgetState.pressed)) {
                        return Colors.lightGreen; // Warna saat tombol ditekan
                      }
                      return secondColor; // Warna default tombol
                    }),
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  child: Text(
                    "ANALYZE RECIPE",
                    style: GoogleFonts.plusJakartaSans(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: double.infinity, // Lebar penuh sesuai ukuran parent
                height: 50, // Tinggi tombol
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(
                        context, '/multiline-food-analyzer-screen');
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.resolveWith<Color>((states) {
                      if (states.contains(WidgetState.pressed)) {
                        return Colors.lightGreen; // Warna saat tombol ditekan
                      }
                      return secondColor; // Warna default tombol
                    }),
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  child: Text(
                    "MULTILINE RECIPE ANALYZER",
                    style: GoogleFonts.plusJakartaSans(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              Text(
                "Recipe Analysis Result:",
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: secondColor,
                ),
              ),
              const SizedBox(height: 15),
              if (nutritionData != null) ...[
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: secondColor, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Card(
                    margin:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Nutrition Facts",
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          NutritionRow(
                            label: "Calories",
                            value: nutritionData!.calories.toStringAsFixed(3),
                            unit: 'kcal',
                            dailyValue: dailyValues?.totalFat,
                          ),
                          NutritionRow(
                            label: "Total Fat",
                            value: nutritionData!.totalFat.toStringAsFixed(3),
                            unit: 'g',
                            dailyValue: dailyValues?.totalFat,
                          ),
                          NutritionRow(
                            label: "Saturated Fat",
                            value: nutritionData!.saturatedFat.toStringAsFixed(3),
                            unit: 'g',
                            dailyValue: dailyValues?.saturatedFat,
                          ),
                          NutritionRow(
                            label: "Cholesterol",
                            value: nutritionData!.cholesterol.toStringAsFixed(3),
                            unit: 'mg',
                            dailyValue: dailyValues?.cholesterol,
                          ),
                          NutritionRow(
                            label: "Sodium",
                            value: nutritionData!.sodium.toStringAsFixed(3),
                            unit: 'mg',
                            dailyValue: dailyValues?.sodium,
                          ),
                          NutritionRow(
                            label: "Carbohydrates",
                            value: nutritionData!.carbohydrates.toStringAsFixed(3),
                            unit: 'g',
                            dailyValue: dailyValues?.carbohydrates,
                          ),
                          NutritionRow(
                            label: "Fiber",
                            value: nutritionData!.fiber.toStringAsFixed(3),
                            unit: 'g',
                            dailyValue: dailyValues?.fiber,
                          ),
                          NutritionRow(
                            label: "Sugars",
                            value: nutritionData!.sugars.toStringAsFixed(3),
                            unit: 'g',
                            dailyValue: null,
                          ),
                          NutritionRow(
                            label: "Protein",
                            value: nutritionData!.protein.toStringAsFixed(3),
                            unit: 'g',
                            dailyValue: dailyValues?.protein,
                          ),
                          NutritionRow(
                            label: "Vitamin D",
                            value: nutritionData!.vitaminD.toStringAsFixed(3),
                            unit: 'µg',
                            dailyValue: dailyValues?.vitaminD,
                          ),
                          NutritionRow(
                            label: "Calcium",
                            value: nutritionData!.calcium.toStringAsFixed(3),
                            unit: 'mg',
                            dailyValue: dailyValues?.calcium,
                          ),
                          NutritionRow(
                            label: "Iron",
                            value: nutritionData!.iron.toStringAsFixed(3),
                            unit: 'mg',
                            dailyValue: dailyValues?.iron,
                          ),
                          NutritionRow(
                            label: "Potassium",
                            value: nutritionData!.potassium.toStringAsFixed(3),
                            unit: 'mg',
                            dailyValue: dailyValues?.potassium,
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "*Percent Daily Values are based on a 2000 calorie diet",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 201, 0, 0)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 20),
              if (ingredientsData != null && ingredientsData!.isNotEmpty) ...[
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: secondColor, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Card(
                    margin: EdgeInsets.zero,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Ingredients",
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Table(
                              border: TableBorder.all(),
                              columnWidths: const {
                                0: FixedColumnWidth(75),
                                1: FixedColumnWidth(60),
                                2: FixedColumnWidth(100),
                                3: FixedColumnWidth(90),
                                4: FixedColumnWidth(80),
                              },
                              children: [
                                // Table header
                                const TableRow(
                                  children: [
                                    Center(
                                        child: Text("Quantity",
                                            style: TextStyle(
                                                fontWeight:
                                                    FontWeight.bold))),
                                    Center(
                                        child: Text("Unit",
                                            style: TextStyle(
                                                fontWeight:
                                                    FontWeight.bold))),
                                    Center(
                                        child: Text("Food",
                                            style: TextStyle(
                                                fontWeight:
                                                    FontWeight.bold))),
                                    Center(
                                        child: Text("Calories",
                                            style: TextStyle(
                                                fontWeight:
                                                    FontWeight.bold))),
                                    Center(
                                        child: Text("Weight",
                                            style: TextStyle(
                                                fontWeight:
                                                    FontWeight.bold))),
                                  ],
                                ),
                                // Table rows
                                for (var ingredient in ingredientsData!)
                                  TableRow(
                                    children: [
                                      Center(
                                          child: Text(ingredient.quantity.toDouble().toString())),
                                      Center(
                                          child:
                                              Text(ingredient.unit)),
                                      Center(
                                          child:
                                              Text(ingredient.food)),
                                      Center(
                                          child: Text(
                                              ingredient.calories.toString())),
                                      Center(
                                          child: Text(
                                              ingredient.weight.toString())),
                                    ],
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ],
          ),
        ),
      ]),
    );
  }
}
