import 'package:flutter/material.dart';
import 'package:good_mind/controllers/body_part_exercise_controller.dart';
import 'package:good_mind/controllers/exercise_controller.dart';
import 'package:good_mind/screen/home/home_screen.dart';
import 'package:good_mind/screen/loading_screen.dart';
import 'package:good_mind/screen/food_analysis/single_food_analyzer_screen.dart';
import 'package:good_mind/screen/workouts/workouts_screen.dart';
import 'package:good_mind/theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'controllers/body_part_controller.dart';
import 'screen/food_analysis/multiline_food_analyzer_screen.dart';
import 'screen/profile/profile_screen.dart';
import 'screen/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => BodyPartController()..loadBodyParts()),
        ChangeNotifierProvider(create: (_) => BodyPartExerciseController()),
        ChangeNotifierProvider(create: (_) => ExerciseController()..loadExercises()),
      ],
      child: MaterialApp(
        title: 'Good Mind',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.plusJakartaSansTextTheme(),
          colorScheme: ColorScheme.fromSeed(seedColor: secondColor),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
        routes: {
          "/loading-screen": (context) => const LoadingScreen(),
          "/home-screen": (context) => const HomeScreen(),
          "/profile-screen": (context) => const ProfileScreen(),
          "/multiline-food-analyzer-screen": (context) =>
              const MultiLineFoodAnalyzerScreen(),
          "/single-food-analyzer-screen": (context) =>
              const SingleFoodAnalyzerScreen(),
          "/workouts-screen": (context) => const WorkoutsScreen(),
        },
      ),
    );
  }
}
