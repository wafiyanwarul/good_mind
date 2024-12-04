import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/app_theme.dart';

class ProfileInfoFieldWidget extends StatelessWidget {
  final IconData icon; 
  final String label; 
  final String data;

  const ProfileInfoFieldWidget({
    super.key,
    required this.icon,
    required this.label,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: secondColor,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: const Color.fromARGB(211, 104, 104, 104).withOpacity(0.2),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: 25,
                color: secondColor,
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Text(
                  data,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: secondColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
