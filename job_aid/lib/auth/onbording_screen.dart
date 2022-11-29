import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:get/get.dart';
import 'package:job_aid/auth/auth_type.dart';
import 'package:job_aid/constants/colors.dart';
import 'package:simple_shadow/simple_shadow.dart';

class OnbordingScreen extends StatefulWidget {
  const OnbordingScreen({super.key});

  @override
  State<OnbordingScreen> createState() => _OnbordingScreenState();
}

class _OnbordingScreenState extends State<OnbordingScreen> {
  Future getCurrentLocationData() async {
    print('status');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnBoardingSlider(
        finishButtonText: 'Let\'s Started',
        finishButtonTextStyle: const TextStyle(
          fontSize: 14,
          color: AppColor.white,
        ),
        onFinish: () {
          Get.offAll(const AuthType());
        },
        finishButtonColor: AppColor.appThemeColor,
        skipTextButton: const Text(
          'Skip',
          style: TextStyle(
            fontSize: 14,
            color: AppColor.blackColor,
          ),
        ),
        skipFunctionOverride: () {
          Get.offAll(const AuthType());
        },
        controllerColor: AppColor.blackColor,
        totalPage: 2,
        headerBackgroundColor: Colors.white,
        pageBackgroundColor: Colors.white,
        background: [
          SimpleShadow(
            opacity: 0.25,
            color: Colors.black,
            offset: const Offset(2, 2),
            sigma: 2,
            child: Image.asset(
              'assets/images/onboarding_1.png',
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          SimpleShadow(
            opacity: 0.25,
            color: Colors.black,
            offset: const Offset(2, 2),
            sigma: 2,
            child: Image.asset(
              'assets/images/onboarding_2.png',
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width,
            ),
          ),
        ],
        speed: 1.8,
        pageBodies: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const <Widget>[
                SizedBox(
                  height: 480,
                ),
                Text(
                  'Make your dream career with job',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColor.primaryColor,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Bring your insight, imagination and healthy disregard for the impossible.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black26,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const <Widget>[
                SizedBox(
                  height: 480,
                ),
                Text(
                  'Make interview process more easier',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColor.primaryColor,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Create a unique emotional story that describes better than words',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black26,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
