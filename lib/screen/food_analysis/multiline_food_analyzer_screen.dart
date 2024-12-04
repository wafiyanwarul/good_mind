import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import 'package:good_mind/theme/app_theme.dart';

class MultiLineFoodAnalyzerScreen extends StatefulWidget {
  const MultiLineFoodAnalyzerScreen({super.key});

  @override
  State<MultiLineFoodAnalyzerScreen> createState() =>
      _MultiLineFoodAnalyzerScreenState();
}

class _MultiLineFoodAnalyzerScreenState
    extends State<MultiLineFoodAnalyzerScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController ingredientsController = TextEditingController();
  Map<String, dynamic>? nutritionData;
  Map<String, dynamic>? dailyValues;
  List<Map<String, dynamic>>? ingredientsData;

  Future<void> analyzeRecipe() async {
    // print("Analyze Recipe button clicked");

    // Mengambil input dari TextField
    String title = titleController.text;
    String ingredientsText = ingredientsController.text;

    if (title.isEmpty || ingredientsText.isEmpty) {
      // print("Title and Ingredients cannot be empty");
      return;
    }

    // Mengonversi input ingredients multi-line ke dalam array
    List<String> ingredients = ingredientsText
        .split('\n')
        .map((line) => line.trim())
        .where((line) => line.isNotEmpty)
        .toList();

    // Membuat request JSON untuk dikirim ke API
    final requestBody = jsonEncode({
      "title": title,
      "ingr": ingredients,
      "summary": "string",
      "yield": "string",
      "time": "string",
      "img": "string",
      "prep": ["string"]
    });

    // Membuat request POST ke API
    final response = await http.post(
      Uri.parse(
          'https://api.edamam.com/api/nutrition-details?app_id=de6fc5b5&app_key=1b29c47bd90940c25c255213539448e1'),
      headers: {"Content-Type": "application/json"},
      body: requestBody,
    );

    // Cek apakah request berhasil
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      // print(data); // Debug log untuk melihat struktur data

      setState(() {
        // Memetakan data ke variabel lokal dengan pengecekan null
        nutritionData = {
          "calories": data["calories"] ?? 0,
          "totalFat": data["totalNutrients"]?["FAT"]?["quantity"] ?? 0,
          "saturatedFat": data["totalNutrients"]?["FASAT"]?["quantity"] ?? 0,
          "cholesterol": data["totalNutrients"]?["CHOLE"]?["quantity"] ?? 0,
          "sodium": data["totalNutrients"]?["NA"]?["quantity"] ?? 0,
          "carbohydrates": data["totalNutrients"]?["CHOCDF"]?["quantity"] ?? 0,
          "fiber": data["totalNutrients"]?["FIBTG"]?["quantity"] ?? 0,
          "sugars": data["totalNutrients"]?["SUGAR"]?["quantity"] ?? 0,
          "protein": data["totalNutrients"]?["PROCNT"]?["quantity"] ?? 0,
          "vitaminD": data["totalNutrients"]?["VITD"]?["quantity"] ?? 0,
          "calcium": data["totalNutrients"]?["CA"]?["quantity"] ?? 0,
          "iron": data["totalNutrients"]?["FE"]?["quantity"] ?? 0,
          "potassium": data["totalNutrients"]?["K"]?["quantity"] ?? 0,
        };

        // Memetakan data untuk % Daily Values
        dailyValues = {
          "totalFat": data["totalDaily"]?["FAT"]?["quantity"] ?? 0,
          "saturatedFat": data["totalDaily"]?["FASAT"]?["quantity"] ?? 0,
          "cholesterol": data["totalDaily"]?["CHOLE"]?["quantity"] ?? 0,
          "sodium": data["totalDaily"]?["NA"]?["quantity"] ?? 0,
          "carbohydrates": data["totalDaily"]?["CHOCDF"]?["quantity"] ?? 0,
          "fiber": data["totalDaily"]?["FIBTG"]?["quantity"] ?? 0,
          "protein": data["totalDaily"]?["PROCNT"]?["quantity"] ?? 0,
          "vitaminD": data["totalDaily"]?["VITD"]?["quantity"] ?? 0,
          "calcium": data["totalDaily"]?["CA"]?["quantity"] ?? 0,
          "iron": data["totalDaily"]?["FE"]?["quantity"] ?? 0,
          "potassium": data["totalDaily"]?["K"]?["quantity"] ?? 0,
        };

        // Memetakan data bahan dengan pengecekan null
        ingredientsData = (data["ingredients"] as List?)?.map((ingredient) {
              return {
                "quantity": ingredient["parsed"]?[0]["quantity"] ?? 0,
                "unit": ingredient["parsed"]?[0]["measure"] ?? "unknown",
                "food": ingredient["parsed"]?[0]["food"] ?? "unknown",
                "calories": ingredient["parsed"]?[0]["nutrients"]["ENERC_KCAL"]["quantity"] ?? 0,
                "weight": ingredient["parsed"]?[0]["weight"] ?? 0
              };
            }).toList() ??
            [];
      });
    } else {
      // Error handling jika request gagal
      setState(() {
        nutritionData = null;
        dailyValues = null;
        ingredientsData = null;
      });
      // print("Failed to fetch data from API, status code: ${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Multi-Line Recipe Analyzer',
          style: appbarHeadingStyle,
        ),
        centerTitle: true,
        backgroundColor: secondColor,
        leading: InkWell(
          onTap: (){Navigator.pop(context);},
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          const SizedBox(height: 20),
          Text(
            "Recipe Title",
            style: GoogleFonts.plusJakartaSans(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: secondColor,
            ),
          ),
          const SizedBox(height: 10),
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
            "Recipe Ingredients (one recipe/line)",
            style: GoogleFonts.plusJakartaSans(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: secondColor,
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: ingredientsController,
            maxLines: null,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              hintText: "use comma (,) in the last line \nexcept last bottom \nExample: \n300 gram rice,\n65 gram tofu",
              hintStyle: GoogleFonts.plusJakartaSans(
                color: secondColor,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: TextButton(
              onPressed: analyzeRecipe,
              style: ButtonStyle(
                backgroundColor:
                    WidgetStateProperty.resolveWith<Color>((states) {
                  if (states.contains(WidgetState.pressed)) {
                    return Colors.lightGreen;
                  }
                  return secondColor;
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
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
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
                      _buildNutritionRow(
                          "Total Calories", nutritionData!["calories"], "kcal"),
                      const Divider(color: Colors.grey),
                      _buildNutritionRow(
                          "Total Fat",
                          nutritionData!["totalFat"],
                          "g",
                          dailyValues!["totalFat"]),
                      const Divider(color: Colors.grey),
                      _buildNutritionRow(
                          "Saturated Fat",
                          nutritionData!["saturatedFat"],
                          "g",
                          dailyValues!["saturatedFat"]),
                      const Divider(color: Colors.grey),
                      _buildNutritionRow(
                          "Cholesterol",
                          nutritionData!["cholesterol"],
                          "mg",
                          dailyValues!["cholesterol"]),
                      const Divider(color: Colors.grey),
                      _buildNutritionRow("Sodium", nutritionData!["sodium"],
                          "mg", dailyValues!["sodium"]),
                      const Divider(color: Colors.grey),
                      _buildNutritionRow(
                          "Total Carbohydrates",
                          nutritionData!["carbohydrates"],
                          "g",
                          dailyValues!["carbohydrates"]),
                      const Divider(color: Colors.grey),
                      _buildNutritionRow("Fiber", nutritionData!["fiber"], "g",
                          dailyValues!["fiber"]),
                      const Divider(color: Colors.grey),
                      _buildNutritionRow(
                          "Sugars", nutritionData!["sugars"], "g"),
                      const Divider(color: Colors.grey),
                      _buildNutritionRow("Protein", nutritionData!["protein"],
                          "g", dailyValues!["protein"]),
                      const Divider(color: Colors.grey),
                      _buildNutritionRow(
                          "Vitamin D",
                          nutritionData!["vitaminD"],
                          "µg",
                          dailyValues!["vitaminD"]),
                      const Divider(color: Colors.grey),
                      _buildNutritionRow("Calcium", nutritionData!["calcium"],
                          "mg", dailyValues!["calcium"]),
                      const Divider(color: Colors.grey),
                      _buildNutritionRow("Iron", nutritionData!["iron"], "mg",
                          dailyValues!["iron"]),
                      const Divider(color: Colors.grey),
                      _buildNutritionRow(
                          "Potassium",
                          nutritionData!["potassium"],
                          "mg",
                          dailyValues!["potassium"]),
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
          const SizedBox(height: 10),
          if (ingredientsData != null) ...[
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
                                            fontWeight: FontWeight.bold))),
                                Center(
                                    child: Text("Unit",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold))),
                                Center(
                                    child: Text("Food",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold))),
                                Center(
                                    child: Text("Calories",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold))),
                                Center(
                                    child: Text("Weight",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold))),
                              ],
                            ),
                            // Table rows
                            for (var ingredient in ingredientsData!)
                              TableRow(
                                children: [
                                  Center(
                                      child: Text("${ingredient["quantity"]}")),
                                  Center(child: Text("${ingredient["unit"]}")),
                                  Center(child: Text("${ingredient["food"]}")),
                                  Center(
                                      child: Text(
                                          "${ingredient["calories"]} kcal")),
                                  Center(
                                      child: Text("${ingredient["weight"]} g")),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ],
      ),
    );
  }

  Widget _buildNutritionRow(String label, dynamic value, String unit,
      [dynamic dailyValue]) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("$label: $value $unit", style: const TextStyle(fontSize: 16)),
          if (dailyValue != null)
            Text("(${dailyValue.toStringAsFixed(3)}%)",
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
