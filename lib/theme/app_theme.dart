import "package:flutter/material.dart"
    show Color, Colors, FontWeight, TextStyle;
import "package:google_fonts/google_fonts.dart";

const blackColor = Colors.black;
const greyColor = Color.fromARGB(255, 75, 75, 75);
const mainColor = Color(0xff0F67FE);
const secondColor = Color.fromARGB(255, 46, 39, 78);

TextStyle mainHeadingStyle = GoogleFonts.plusJakartaSans(
  fontSize: 18,
  fontWeight: FontWeight.bold,
  color: secondColor,
);

TextStyle mainHeadingStyle2 = GoogleFonts.plusJakartaSans(
  fontSize: 18,
  fontWeight: FontWeight.bold,
  color: Colors.white,
);

TextStyle subHeadingStyle = GoogleFonts.plusJakartaSans(
  fontSize: 14,
  fontWeight: FontWeight.bold,
  color: Colors.white,
);

TextStyle subHeadingStyle2 = GoogleFonts.plusJakartaSans(
  fontSize: 12,
  fontWeight: FontWeight.w600,
  color: const Color.fromARGB(255, 189, 189, 189),
);

TextStyle subHeadingStyle3 = GoogleFonts.plusJakartaSans(
  fontSize: 12,
  fontWeight: FontWeight.bold,
  color: Colors.white,
);

TextStyle subHeadingStyle4 = GoogleFonts.plusJakartaSans(
  fontSize: 10,
  fontWeight: FontWeight.w600,
  color: const Color.fromARGB(255, 189, 189, 189),
);

TextStyle appbarHeadingStyle = GoogleFonts.plusJakartaSans(
  fontSize: 22,
  fontWeight: FontWeight.w400,
  color: Colors.white,
);

TextStyle mainNotFoundStyle = GoogleFonts.plusJakartaSans(
  color: secondColor,
  fontSize: 20,
  fontWeight: FontWeight.bold,
);
