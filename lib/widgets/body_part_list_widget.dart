import 'package:flutter/material.dart';
import 'package:good_mind/screen/body_part/body_part_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:good_mind/controllers/body_part_controller.dart';
import 'package:good_mind/theme/app_theme.dart';

import '../controllers/body_part_exercise_controller.dart';

class BodyPartListWidget extends StatelessWidget {
  const BodyPartListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<BodyPartController>(context);

    return Container(
      color: Colors.white,
      child: controller.isLoading
          ? const Center(child: CircularProgressIndicator())
          : controller.bodyParts.isEmpty
              ? Center(
                  child: Text(
                    "No data found",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: secondColor,
                    ),
                  ),
                )
              : SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: controller.bodyParts.map(
                      (bodyPart) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChangeNotifierProvider(
                                  create: (_) => BodyPartExerciseController()
                                    ..loadBodyPartExercises(bodyPart.name),
                                  child:
                                      BodyPartScreen(bodyPart: bodyPart.name),
                                ),
                              ),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 10),
                            width: MediaQuery.of(context).size.width * 0.4,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: secondColor,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Center(
                              child: Text(
                                bodyPart.name.toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ).toList(),
                  ),
                ),
    );
  }
}
