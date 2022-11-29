import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:get/get.dart';
import 'package:job_aid/constants/colors.dart';
import 'package:job_aid/main.dart';
import 'package:job_aid/screens/candidate_home/sub_screens/candidate_application.dart';
import 'package:job_aid/screens/candidate_home/sub_screens/candidate_home.dart';
import 'package:job_aid/screens/candidate_home/sub_screens/candidate_messages.dart';
import 'package:job_aid/screens/candidate_home/sub_screens/candidate_near_jobs.dart';

import 'sub_screens/profile_setup_screen.dart';

class CandidateDashboard extends StatefulWidget {
  const CandidateDashboard({super.key});

  @override
  State<CandidateDashboard> createState() => _CandidateDashboardState();
}

class _CandidateDashboardState extends State<CandidateDashboard> {
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
        leading: MaterialButton(
          padding: EdgeInsets.all(10),
          onPressed: () {
            Get.to(ProfileSetupScreen());
          },
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              image: DecorationImage(
                image: NetworkImage(
                  jsonDecode(
                      prefs!.getString('userDetails')!)['profile_picture'],
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
              jsonDecode(prefs!.getString('userDetails')!)['name'],
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
          ? CandidateHomeScreen()
          : selectedIndex == 1
              ? CandidateApplication()
              : selectedIndex == 2
                  ? CandidateMessages()
                  : CandidateNearJobs(),
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
          BottomNavigationBarItem(
            icon: Icon(FontAwesome.location),
            label: 'Near Me',
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
