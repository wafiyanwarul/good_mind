import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:square_progress_indicator/square_progress_indicator.dart';
import '../theme/appTheme.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double _value = 0;

  @override
  void initState() {
    super.initState();
    // Memulai progress ketika halaman dimuat
    _startLoading();
  }

  // Fungsi untuk memulai progress dari 0% hingga 100%
  void _startLoading() {
    Timer.periodic(const Duration(milliseconds: 50), (timer) {
      setState(() {
        _value += 0.01; // Menambah progress 1% setiap kali
      });
      if (_value >= 1.0) {
        timer.cancel();
        // Pindah ke halaman HomeScreen setelah loading selesai
        Navigator.pushNamed(context, '/home-screen');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: mainColor,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            // Posisi gambar-gambar
            Positioned(
              top: MediaQuery.of(context).size.height * 0,
              left: 35,
              right: 200,
              child: Image.asset(
                'assets/images/vector_2.png',
                width: MediaQuery.of(context).size.width * 0.4,
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.25,
              left: 60,
              right: 5,
              child: Image.asset(
                'assets/images/vector_3.png',
                width: MediaQuery.of(context).size.width * 0.4,
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.5,
              left: 5,
              right: 150,
              child: Image.asset(
                'assets/images/vector_1.png',
                width: MediaQuery.of(context).size.width * 0.4,
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.7,
              left: 65,
              right: 0,
              child: Image.asset(
                'assets/images/vector_4.png',
                width: MediaQuery.of(context).size.width * 0.4,
              ),
            ),
            // Progress Indicator
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Loading....",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 30),
                    SquareProgressIndicator(
                      value: _value,
                      width: 165,
                      height: 165,
                      borderRadius: 15,
                      startPosition: StartPosition.leftCenter,
                      strokeCap: StrokeCap.square,
                      clockwise: true,
                      color: Colors.white,
                      emptyStrokeColor: const Color.fromARGB(255, 39, 149, 176).withOpacity(.5),
                      strokeWidth: 16,
                      emptyStrokeWidth: 16,
                      strokeAlign: SquareStrokeAlign.center,
                      child: Text(
                        "${(_value * 100).toStringAsFixed(0)}%", // Tampilkan persentase
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
