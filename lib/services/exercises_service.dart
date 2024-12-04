import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/exercise.dart';

class ExerciseService {
  final String apiUrl = "https://exercisedb.p.rapidapi.com/exercises?limit=30";
  final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'X-Rapidapi-Host': 'exercisedb.p.rapidapi.com',
    'X-Rapidapi-Key': 'YOUR_API_KEY',
  };

  Future<List<ExerciseModel>> fetchExercises() async {
    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: headers,
      );
      debugPrint("Status Code: ${response.statusCode}");
      debugPrint("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((e) => ExerciseModel.fromJson(e)).toList();
      } else {
        throw Exception(
            'Failed to load exercises. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetching exercises: $e');
      throw Exception('Error fetching exercises: $e');
    }
  }
}