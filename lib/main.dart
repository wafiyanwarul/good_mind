import 'package:flutter/material.dart';
import 'package:good_mind/pages/home_screen.dart';
import 'package:good_mind/pages/loading_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pages/profile_screen.dart';
import 'pages/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.plusJakartaSansTextTheme(),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
      routes: {
        "/loading-screen": (context) => const LoadingScreen(),
        "/home-screen": (context) => const HomeScreen(),
        "/profile-screen": (context) => const ProfileScreen(),
      },
    );
  }
}
