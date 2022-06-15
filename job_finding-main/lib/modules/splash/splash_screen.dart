import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:job_finding/router_name.dart';
import 'package:job_finding/utils/constants.dart';
import 'package:job_finding/utils/k_images.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              onPageChanged: (value) {
                setState(() {
                  _currentIndex = value;
                });
              },
              children: [
                Image.asset(Kimages.onboarding_1),
                Image.asset(Kimages.onboarding_2),
              ],
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: secondaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(48),
                topRight: Radius.circular(48),
              ),
            ),
            padding: const EdgeInsets.only(top: 50),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _currentIndex == 0
                        ? 'Make your dream\ncareer with job'
                        : 'Make interview\nprocess more easier',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: primaryColor,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Create a unique emotional story that\ndescribes better than words',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: primaryColor.withOpacity(0.8),
                    ),
                  ),
                  const SizedBox(height: 30),
                  AnimatedSmoothIndicator(
                    activeIndex: _currentIndex,
                    count: 2,
                    effect: WormEffect(
                      activeDotColor: primaryColor,
                      dotColor: primaryColor.withOpacity(0.2),
                      dotHeight: 10,
                      dotWidth: 10,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      SvgPicture.asset(Kimages.onboardingBottom),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, Routes.continueAsScreen);
                        },
                        child: Text(
                          _currentIndex == 0 ? 'Skip' : "Let's Go",
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
