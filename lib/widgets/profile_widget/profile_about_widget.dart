import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/app_theme.dart'; // Pastikan path sesuai dengan lokasi tema Anda

class ProfileAboutWidget extends StatelessWidget {
  final String name; // Nama pengguna
  final String subtitle; // Subtitle seperti ID atau deskripsi singkat
  final String about; // Deskripsi tentang pengguna

  const ProfileAboutWidget({
    super.key,
    required this.name,
    required this.subtitle,
    required this.about,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Text(
            name,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: secondColor,
            ),
          ),
        ),
        const SizedBox(height: 5),
        Center(
          child: Text(
            subtitle,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color.fromARGB(255, 56, 56, 56),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          width: MediaQuery.of(context).size.width,
          child: Text(
            about,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color.fromARGB(255, 80, 80, 80),
            ),
          ),
        ),
      ],
    );
  }
}
