import 'package:flutter/material.dart';
import 'package:good_mind/models/body_part_exercise.dart';
import 'package:good_mind/services/body_part_exercise_service.dart';

class BodyPartExerciseController with ChangeNotifier {
  final BodyPartExerciseService _service = BodyPartExerciseService();
  List<BodyPartExercise> _exercises = [];
  bool _isLoading = false;

  List<BodyPartExercise> get exercises => _exercises;
  bool get isLoading => _isLoading;

  Future<void> loadBodyPartExercises(String bodyPart) async {
    _isLoading = true;
    notifyListeners();

    try {
      _exercises = await _service.fetchExercises(bodyPart);
    } catch (e) {
      debugPrint('Error fetching exercises: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
