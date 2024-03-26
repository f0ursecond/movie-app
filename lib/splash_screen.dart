import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/constant/color_constant.dart';
import 'package:movie_app/core/navigation_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => NavigationScreen()),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      body: Center(
        child: AnimatedTextKit(animatedTexts: [
          TypewriterAnimatedText(
            speed: Duration(milliseconds: 90),
            'Netflix',
            textStyle: TextStyle(
              fontSize: 30.sp,
              color: Colors.red.shade400,
              letterSpacing: 1,
            ),
          ),
        ]),
      ),
    );
  }
}
