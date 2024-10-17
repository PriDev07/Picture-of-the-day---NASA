import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nasa_api/screens/home.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to Home after 3 seconds
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 74, 96, 132),
      body: Center(
        child: SvgPicture.asset(
          "assets/nasa-logo.svg",
          width: 200,
        ),
      ),
    );
  }
}
