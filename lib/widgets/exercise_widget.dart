import 'package:flutter/material.dart';
import 'package:good_mind/controllers/exercise_controller.dart';
import 'package:good_mind/theme/app_theme.dart';
import 'package:provider/provider.dart';

class ExerciseWidget extends StatelessWidget {
  final Function(dynamic exercise) onTapExercise; // Tambahkan parameter

  const ExerciseWidget({super.key, required this.onTapExercise});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ExerciseController>(context);

    if (controller.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (controller.hasNoResults) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/empty_data.png',
              height: 200,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 5),
            Text("Not Found", style: mainNotFoundStyle),
          ],
        ),
      );
    }
    return GridView.builder(
      // padding: const EdgeInsets.only(top: 5),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: controller.exercises.length,
      shrinkWrap: true, // Untuk mendukung layout yang fleksibel
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final exercise = controller.exercises[index];
        return GestureDetector(
          onTap: () => onTapExercise(exercise),
          child: Container(
            decoration: BoxDecoration(
              color: secondColor,
              border: Border.all(
                color: secondColor,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Image.network(
                      exercise.gifUrl.isNotEmpty
                          ? exercise.gifUrl
                          : 'https://via.placeholder.com/150',
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.error, color: Colors.red);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          exercise.name,
                          style: subHeadingStyle3,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          exercise.bodyPart,
                          style: subHeadingStyle4,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
