import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_aid/auth/onbording_screen.dart';
import 'package:job_aid/constants/colors.dart';
import 'package:job_aid/constants/k_images.dart';
import 'package:simple_shadow/simple_shadow.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () async {
      Get.off(const OnbordingScreen());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        color: AppColor.white,
        image: DecorationImage(
          image: AssetImage('assets/images/background.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: SimpleShadow(
            opacity: 0.25,
            color: Colors.black,
            offset: const Offset(2, 2),
            sigma: 2,
            child: Image.asset(
              Kimages.logoBlackIcon,
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.width / 2,
            ),
          ),
        ),
      ),
    );
  }
}
