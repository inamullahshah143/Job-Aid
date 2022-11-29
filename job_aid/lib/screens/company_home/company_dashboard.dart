import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:get/get.dart';
import 'package:job_aid/auth/splash_screen.dart';
import 'package:job_aid/constants/colors.dart';
import 'package:job_aid/constants/components.dart';
import 'package:job_aid/constants/k_images.dart';
import 'package:job_aid/main.dart';
import 'package:job_aid/screens/company_home/sub_screens/company_application.dart';
import 'package:job_aid/screens/company_home/sub_screens/company_home.dart';
import 'package:job_aid/screens/company_home/sub_screens/company_messages.dart';
import 'package:job_aid/screens/company_home/sub_screens/compnay_profile_screen.dart';
import 'package:job_aid/utils/auth_helper.dart';

class CompanyDashboard extends StatefulWidget {
  const CompanyDashboard({super.key});

  @override
  State<CompanyDashboard> createState() => _CompanyDashboardState();
}

class _CompanyDashboardState extends State<CompanyDashboard> {
  int? selectedIndex;
  @override
  void initState() {
    selectedIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Components.showAlertDialog(context);
              AuthenticationHelper().signOut().whenComplete(() {
                prefs!.setString('userDetails', '');
                Get.offAll(SplashScreen());
              });
            },
            icon: SvgPicture.asset(
              Kimages.logoutIcon,
              color: Colors.black,
              width: 20,
              height: 20,
            ),
          )
        ],
        leading: MaterialButton(
          padding: EdgeInsets.all(10),
          onPressed: () {
            Get.to(CompanyProfileScreen());
          },
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              image: DecorationImage(
                image: NetworkImage(
                  jsonDecode(prefs!.getString('userDetails')!)['company_logo'],
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${greeting().toString()} 👋',
              style: TextStyle(
                fontSize: 12,
                color: AppColor.blackColor,
                fontWeight: FontWeight.w200,
              ),
            ),
            Text(
              jsonDecode(prefs!.getString('userDetails')!)['company_name'],
              style: TextStyle(
                fontSize: 18,
                height: 1.25,
                color: AppColor.primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
      body: selectedIndex == 0
          ? CompanyHomeScreen()
          : selectedIndex == 1
              ? CompnayApplication()
              : CompanyMessages(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        elevation: 5,
        iconSize: 20,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesome5.briefcase),
            label: 'Applications',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesome.chat_empty),
            label: 'Messages',
          ),
        ],
        currentIndex: selectedIndex!,
        fixedColor: AppColor.primaryColor,
        showUnselectedLabels: true,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        unselectedItemColor: AppColor.placeholder.withOpacity(0.5),
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
      ),
    );
  }

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    }
    if (hour < 17) {
      return 'Good Afternoon';
    }
    return 'Good Evening';
  }
}
