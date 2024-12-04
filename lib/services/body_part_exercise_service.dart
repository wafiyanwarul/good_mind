import 'dart:convert';
import 'package:good_mind/models/body_part_exercise.dart';
import 'package:http/http.dart' as http;

class BodyPartExerciseService {
  static const String _baseUrl = "https://exercisedb.p.rapidapi.com/exercises/bodyPart";
  static const Map<String, String> _headers = {
    'X-Rapidapi-Host': 'exercisedb.p.rapidapi.com',
    'X-Rapidapi-Key': 'YOUR_API_KEY',
  };

  Future<List<BodyPartExercise>> fetchExercises(String bodyPart, {int limit = 60}) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/$bodyPart?limit=$limit'),
      headers: _headers,
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => BodyPartExercise.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load exercises');
    }
  }
}
