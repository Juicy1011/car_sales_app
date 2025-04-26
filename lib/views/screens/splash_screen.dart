import 'dart:async'; // Required for Timer
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // For navigation (Get.offNamed)
import 'package:voitureRoyale/configs/mycolors.dart';

// Optional: Import provider if needed for pre-caching logic
// import 'package:voitureRoyale/main.dart'; // If backgroundImageProvider is in main

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isPrecacheInitiated = false;
  @override
  void initState() {
    super.initState();
    _startTimerAndNavigate();
    // Optional: Start background image pre-caching here
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Pre-cache the image here, ensuring it only runs once
    if (!_isPrecacheInitiated) {
      _precacheBackgroundImage();
      _isPrecacheInitiated = true; // Set flag to true after initiating
    }
  }

  // Function to pre-cache the background image (moved from main.dart)
  void _precacheBackgroundImage() {
    // Define the provider here or import from main.dart
    final ImageProvider backgroundImageProvider = AssetImage(
        "assets/images/background84_copy.jpg"); // Ensure path is correct & image is optimized!
    precacheImage(backgroundImageProvider, context).then((_) {
      print("Background image precached successfully during splash.");
    }).catchError((e, stackTrace) {
      print("Error precaching image during splash: $e\n$stackTrace");
      // Decide how to handle error - app can likely continue anyway
    });
  }

  void _startTimerAndNavigate() {
    print("SPLASH: Starting navigation timer (3 seconds)...");
    // Set the duration for the splash screen
    const splashDuration = Duration(
        seconds: 3); // Adjust duration as needed (2-4 seconds is common)

    Timer(splashDuration, () {
      print("SPLASH: Timer finished."); // <-- ADD
      if (mounted) {
        print("SPLASH: Navigating to '/' (Login Screen)..."); // <-- ADD
        Get.offNamed("/");
      } else {
        print(
            "SPLASH: Timer finished, but widget not mounted. Skipping navigation."); // <-- ADD
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Optional: Set a background color, maybe match your theme or login background
      backgroundColor: SecondaryColor,
      // Or use one of your theme colors:
      // backgroundColor: mainColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display the logo
            Image.asset(
              "assets/images/logo3.png",
              height: 150, // Adjust size as needed
              // width: 150, // You can also set width
            ),
            const SizedBox(height: 20), // Optional spacing
            // Optional: Add a loading indicator if doing heavy work
            // CircularProgressIndicator(
            //   valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            // ),
            // Optional: Add a simple text label
            // Text(
            //   'Voiture Royale',
            //   style: TextStyle(
            //     fontSize: 24,
            //     fontWeight: FontWeight.bold,
            //     color: Colors.white, // Adjust color based on background
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
