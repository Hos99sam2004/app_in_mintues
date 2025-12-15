import 'package:flutter/material.dart';
import 'package:flutter_application_1/onbording.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const Onbording()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// الخلفية (الصورة تحت)
          Positioned.fill(
            child: Image.asset('assets/logo.jpg', fit: BoxFit.cover),
          ),

          /// النص فوق الصورة
          Positioned(
            bottom: 60, // تحكم في ارتفاع الكلمة من تحت
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'ذكرني',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      color: Colors.black54,
                      blurRadius: 6,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
