import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:good_mind/theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart'; // Import untuk format tanggal

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    // Mendapatkan tanggal saat ini
    String currentDate = DateFormat('dd/MM/yyyy').format(DateTime.now());

    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: secondColor, // Ganti sesuai kebutuhan
      titleSpacing: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const SizedBox(width: 15),
              const Icon(
                CupertinoIcons.calendar_today,
                size: 25,
                color: Colors.white,
              ),
              const SizedBox(width: 12),
              Text(
                currentDate,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2.5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  title,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: secondColor,
                  ),
                ),
              ),
              const SizedBox(width: 20),
              const Icon(
                CupertinoIcons.bell_solid,
                size: 25,
                color: Colors.white,
              ),
              const SizedBox(width: 15),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
