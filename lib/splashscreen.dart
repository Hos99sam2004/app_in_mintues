import 'package:flutter/material.dart';
import 'package:flutter_application_1/onbording.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (context) => Onbording()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Image.asset(
            'assets/logo.jpg',
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
