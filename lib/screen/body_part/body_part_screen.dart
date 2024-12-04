import 'package:flutter/material.dart';
import 'package:good_mind/controllers/body_part_exercise_controller.dart';
import 'package:good_mind/screen/body_part/body_part_detail_screen.dart';
import 'package:good_mind/theme/app_theme.dart';
import 'package:provider/provider.dart';

class BodyPartScreen extends StatelessWidget {
  final String bodyPart;

  const BodyPartScreen({super.key, required this.bodyPart});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<BodyPartExerciseController>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${bodyPart.toUpperCase()}  EXERCISES",
          style: appbarHeadingStyle,
        ),
        centerTitle: true,
        backgroundColor: secondColor,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
      ),
      body: controller.isLoading
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: controller.exercises.length,
              itemBuilder: (context, index) {
                final exercise = controller.exercises[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            BodyPartDetailScreen(exercise: exercise),
                      ),
                    );
                  },
                  child: Card(
                    color: secondColor,
                    elevation: 3,
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
                                style: subHeadingStyle,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                exercise.equipment,
                                style: subHeadingStyle2,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
