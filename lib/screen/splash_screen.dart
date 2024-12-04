import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_theme.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/logo_healthplus.png',
              width: 75,
              height: 75,
            ),
            const SizedBox(height: 20),
            Text("goodmind",
                style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                  color: greyColor,
                )),
            const SizedBox(height: 15),
            Text(
              "Your Intelligent AI Health &\nWellness Companion.",
              textAlign: TextAlign.center,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 15,
                color: greyColor,
              ),
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/loading-screen");
              },
              child: const Text("Next"),
            ),
          ],
        ),
      ),
    ));
  }
}
