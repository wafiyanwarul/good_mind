import 'package:flutter/material.dart';
import '../models/exercise.dart';
import '../services/exercises_service.dart';

class ExerciseController with ChangeNotifier {
  final ExerciseService _exerciseService = ExerciseService();
  List<ExerciseModel> _allExercises = []; // Daftar asli semua exercise
  List<ExerciseModel> _filteredExercises = []; // Daftar yang ditampilkan
  bool _isLoading = false;

  List<ExerciseModel> get exercises => _filteredExercises;
  bool get isLoading => _isLoading;
  bool get hasNoResults => _filteredExercises.isEmpty && !_isLoading;

  Future<void> loadExercises() async {
    _isLoading = true;
    notifyListeners();

    try {
      _allExercises = await _exerciseService.fetchExercises();
      _filteredExercises = _allExercises; // Awalnya tampilkan semua
    } catch (e) {
      debugPrint('Error loading exercises: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void searchExercises(String query) {
    if (query.isEmpty) {
      _filteredExercises = _allExercises;
    } else {
      final lowerCaseQuery = query.toLowerCase();

      _filteredExercises = _allExercises.where((exercise) {
        // Cari di semua properti yang relevan
        return exercise.name.toLowerCase().contains(lowerCaseQuery) ||
            exercise.bodyPart.toLowerCase().contains(lowerCaseQuery) ||
            exercise.equipment.toLowerCase().contains(lowerCaseQuery) ||
            exercise.target.toLowerCase().contains(lowerCaseQuery) ||
            exercise.secondaryMuscles.any(
              (muscle) => muscle.toLowerCase().contains(lowerCaseQuery),
            );
      }).toList();
    }
    notifyListeners();
  }
}

