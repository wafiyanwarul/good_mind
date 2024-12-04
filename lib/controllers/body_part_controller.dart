import 'package:flutter/material.dart';
import '../models/body_part.dart';
import '../services/workout_bodypart_list_service.dart';

class BodyPartController with ChangeNotifier {
  
  final WorkoutBodyPartListService _service = WorkoutBodyPartListService();
  List<BodyPart> _bodyParts = [];
  bool _isLoading = false;

  List<BodyPart> get bodyParts => _bodyParts;
  bool get isLoading => _isLoading;

  Future<void> loadBodyParts() async {
    _isLoading = true;
    notifyListeners();

    try {
      final data = await _service.fetchBodyPartList();
      _bodyParts = data.map((name) => BodyPart.fromJson(name)).toList();
    } catch (e) {
      debugPrint('Error fetching body parts: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
