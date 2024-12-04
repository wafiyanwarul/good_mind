class ExerciseModel {
  final String id;
  final String bodyPart;
  final String name;
  final String equipment;
  final String target;
  final String gifUrl;
  final List<String> secondaryMuscles;
  final List<String> instructions;

  ExerciseModel({
    required this.id,
    required this.bodyPart,
    required this.name,
    required this.equipment,
    required this.target,
    required this.gifUrl,
    required this.secondaryMuscles,
    required this.instructions,
  });

  factory ExerciseModel.fromJson(Map<String, dynamic> json) {
    return ExerciseModel(
      id: json['id'],
      bodyPart: json['bodyPart'],
      name: json['name'],
      equipment: json['equipment'],
      target: json['target'],
      gifUrl: json['gifUrl'],
      secondaryMuscles: List<String>.from(json['secondaryMuscles']),
      instructions: List<String>.from(json['instructions']),
    );
  }
}
