import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infoapp/home_screen.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {//Adventure Awaits You
    return Scaffold(
      backgroundColor: const Color(0xff031F2B),
      body: Column(
        children: [
          Expanded(
            flex: 7,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // Center vertically
                  children: [
                    Image.asset('assets/image/intro_logo.png'),
                    const SizedBox(height: 20),
                    Text(
                      'Oddiy hayotdan qoching',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Atrofingizdagi ajoyib tajribalarni kashf eting\nva sizni qiziqarli yashashga majbur qiling!',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w300,
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox.square(dimension: 32,)
                  ],
                ),
              ),
            ),
          ),
          // Button section
          Padding(
            padding: const EdgeInsets.only(left: 32, right: 32, bottom: 56),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen())
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xff5EDFFF),
                  borderRadius: BorderRadius.circular(10), // Rounded corners
                ),
                child: Center(
                  child: Text(
                    'Boshladik', // Update to match the button label in the image
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: const Color(0xff263238), // Text color to contrast with button background
                    ),
                  ),
                ),
              ),
            ),
          )
,
        ],
      ),
    );
  }
}
