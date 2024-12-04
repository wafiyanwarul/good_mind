import 'package:flutter/material.dart';
import 'package:good_mind/models/exercise.dart';
import 'package:good_mind/theme/app_theme.dart';

class ExerciseDetailScreen extends StatelessWidget {
  final ExerciseModel exercise;

  const ExerciseDetailScreen({super.key, required this.exercise});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          exercise.name,
          style: appbarHeadingStyle,
        ),
        centerTitle: true,
        backgroundColor: secondColor,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // GIF Display
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: secondColor, width: 2),
                borderRadius: BorderRadius.circular(
                    15), // Border mengikuti radius dari ClipRRect
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  exercise.gifUrl,
                  height: 400,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: secondColor,
                  borderRadius: BorderRadius.circular(25)),
              child: Column(
                children: [
                  // Equipment & Target Body Part
                  Text(
                    "Equipment: ${exercise.equipment}",
                    style: mainHeadingStyle2,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Target Muscle: ${exercise.target}",
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  // Secondary Muscles
                  Text("Secondary Muscles:", style: mainHeadingStyle2),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: exercise.secondaryMuscles
                        .map(
                          (muscle) => Chip(
                            label: Text(muscle, style: const TextStyle(color: secondColor),),
                            backgroundColor: secondColor.withOpacity(0.1),
                            labelStyle: const TextStyle(color: Colors.white),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 16),
                  // Instructions
                  Text("Instructions:", style: mainHeadingStyle2),
                  const SizedBox(height: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                        exercise.instructions.asMap().entries.map((entry) {
                      final index = entry.key;
                      final instruction = entry.value;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${index + 1}. ",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                            Expanded(
                              child: Text(
                                instruction,
                                style: const TextStyle(fontSize: 16, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
