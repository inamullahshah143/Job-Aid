import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:job_aid/auth/login_screen.dart';
import 'package:job_aid/constants/colors.dart';

import '../constants/k_images.dart';

class AuthType extends StatelessWidget {
  const AuthType({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Image.asset(
                Kimages.logoBlackIcon,
                width: MediaQuery.of(context).size.width / 2.25,
                height: MediaQuery.of(context).size.width / 2.25,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  'Continue as',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: AppColor.blackColor,
                  ),
                ),
              ),
              ContinueButton(
                onTap: () {
                  Get.offAll(const LoginScreen(userType: 'Candidate'));
                },
                text: 'Candidate',
                caption: 'Finding a job here never\nbeen easier than before',
                icon: Kimages.arrowWhite,
                backgroundColor: AppColor.blackColor,
                boxShadow: [
                  BoxShadow(
                    color: AppColor.blackColor.withOpacity(0.4),
                    offset: const Offset(4, 8),
                    blurRadius: 20,
                  ),
                ],
              ),
              ContinueButton(
                onTap: () {
                  Get.offAll(const LoginScreen(userType: 'Company'));
                },
                text: 'Company',
                caption: 'Let’s recruit your great\ncandidate faster here',
                icon: Kimages.arrowWhite,
                backgroundColor: AppColor.primaryColor,
                boxShadow: [
                  BoxShadow(
                    color: AppColor.blackColor.withOpacity(0.4),
                    offset: const Offset(4, 8),
                    blurRadius: 20,
                  ),
                ],
              ),
              const SizedBox(height: 60),
            ],
          ),
        ],
      ),
    );
  }
}

class ContinueButton extends StatelessWidget {
  const ContinueButton({
    Key? key,
    required this.onTap,
    required this.text,
    required this.caption,
    required this.icon,
    required this.backgroundColor,
    this.reverse = false,
    this.boxShadow,
  }) : super(key: key);

  final VoidCallback onTap;
  final String text;
  final String caption;
  final String icon;
  final Color backgroundColor;
  final List<BoxShadow>? boxShadow;
  final bool reverse;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 24, left: 20, right: 20),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: boxShadow,
      ),
      child: InkWell(
        onTap: onTap,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 32,
                horizontal: 40,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: reverse ? AppColor.white : AppColor.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    caption,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: reverse
                          ? AppColor.white.withOpacity(0.8)
                          : AppColor.white.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              right: -8,
              child: SvgPicture.asset(
                Kimages.arrowVector,
                color: AppColor.white.withOpacity(0.25),
              ),
            ),
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              child: SvgPicture.asset(icon),
            ),
          ],
        ),
      ),
    );
  }
}
