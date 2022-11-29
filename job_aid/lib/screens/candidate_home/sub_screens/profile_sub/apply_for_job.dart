import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:job_aid/constants/colors.dart';
import 'package:job_aid/constants/components.dart';
import 'package:job_aid/constants/k_images.dart';
import 'package:job_aid/main.dart';
import 'package:job_aid/screens/candidate_home/components/profile_components.dart';

class ApplyForJob extends StatelessWidget {
  final String jobId;
  final String postedBy;
  const ApplyForJob({super.key, required this.jobId, required this.postedBy});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.transparent,
        foregroundColor: AppColor.blackColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            size: 18,
          ),
        ),
        title: Text(
          'Apply for Job',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              image: DecorationImage(
                image: NetworkImage(
                  jsonDecode(
                      prefs!.getString('userDetails')!)['profile_picture'],
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text(
            jsonDecode(prefs!.getString('userDetails')!)['name'],
            style: TextStyle(
              fontSize: 24,
              height: 2.5,
              color: AppColor.primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            jsonDecode(prefs!.getString('userDetails')!)['experties'],
            style: TextStyle(
              fontSize: 14,
              color: AppColor.blackColor,
              fontWeight: FontWeight.w200,
            ),
          ),
          Divider(
            indent: 25.0,
            endIndent: 25.0,
            color: AppColor.placeholder,
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  //Contact Information
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Card(
                      margin: EdgeInsets.zero,
                      color: AppColor.placeholderBg,
                      elevation: 2,
                      shadowColor: AppColor.placeholder.withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            horizontalTitleGap: 0,
                            leading: SvgPicture.asset(
                              Kimages.contactIcon,
                              width: 20,
                              height: 20,
                              color: AppColor.primaryColor,
                            ),
                            title: Text(
                              'Contact Information',
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColor.blackColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Divider(
                            color: AppColor.placeholder,
                          ),
                          ListTile(
                            minLeadingWidth: 20,
                            dense: true,
                            leading: Icon(
                              Icons.location_on_outlined,
                              size: 18,
                            ),
                            title: Text(
                              jsonDecode(prefs!.getString('userDetails')!)[
                                      'complete_address'] +
                                  ', ' +
                                  jsonDecode(prefs!.getString('userDetails')!)[
                                      'city'] +
                                  ', ' +
                                  jsonDecode(prefs!.getString('userDetails')!)[
                                      'province'],
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColor.blackColor,
                              ),
                            ),
                          ),
                          ListTile(
                            minLeadingWidth: 20,
                            dense: true,
                            leading: Icon(
                              Icons.phone_outlined,
                              size: 18,
                            ),
                            title: Text(
                              jsonDecode(
                                  prefs!.getString('userDetails')!)['phone_no'],
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColor.blackColor,
                              ),
                            ),
                          ),
                          ListTile(
                            minLeadingWidth: 20,
                            dense: true,
                            leading: Icon(
                              Icons.mail_outline,
                              size: 18,
                            ),
                            title: Text(
                              jsonDecode(
                                  prefs!.getString('userDetails')!)['email'],
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColor.blackColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  //Summary
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Card(
                      margin: EdgeInsets.zero,
                      color: AppColor.placeholderBg,
                      elevation: 2,
                      shadowColor: AppColor.placeholder.withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            horizontalTitleGap: 0,
                            leading: SvgPicture.asset(
                              Kimages.summaryIcon,
                              width: 20,
                              height: 20,
                              color: AppColor.primaryColor,
                            ),
                            title: Text(
                              'Summary',
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColor.blackColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Divider(
                            color: AppColor.placeholder,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              jsonDecode(
                                  prefs!.getString('userDetails')!)['about'],
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColor.blackColor,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  //Expected Salary
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Card(
                      margin: EdgeInsets.zero,
                      color: AppColor.placeholderBg,
                      elevation: 2,
                      shadowColor: AppColor.placeholder.withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            horizontalTitleGap: 0,
                            leading: SvgPicture.asset(
                              Kimages.salaryIcon,
                              width: 20,
                              height: 20,
                              color: AppColor.primaryColor,
                            ),
                            title: Text(
                              'Expected Salary',
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColor.blackColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Divider(
                            color: AppColor.placeholder,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: jsonDecode(prefs!
                                                .getString('userDetails')!)[
                                            'expected_salary']['currency'] +
                                        ' ' +
                                        jsonDecode(prefs!
                                                    .getString('userDetails')!)[
                                                'expected_salary']
                                            ['minimum_salary'],
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: AppColor.blackColor,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' - ',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: AppColor.blackColor,
                                    ),
                                  ),
                                  TextSpan(
                                    text: jsonDecode(prefs!
                                                .getString('userDetails')!)[
                                            'expected_salary']['currency'] +
                                        ' ' +
                                        jsonDecode(prefs!
                                                    .getString('userDetails')!)[
                                                'expected_salary']
                                            ['maximum_salary'],
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: AppColor.blackColor,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        ' ${jsonDecode(prefs!.getString('userDetails')!)['expected_salary']['frequency']}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w900,
                                      color: AppColor.blackColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  //Work Experience
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Card(
                      margin: EdgeInsets.zero,
                      color: AppColor.placeholderBg,
                      elevation: 2,
                      shadowColor: AppColor.placeholder.withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            horizontalTitleGap: 0,
                            leading: SvgPicture.asset(
                              Kimages.experienceIcon,
                              width: 20,
                              height: 20,
                              color: AppColor.primaryColor,
                            ),
                            title: Text(
                              'Work Experience',
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColor.blackColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Divider(
                            color: AppColor.placeholder,
                          ),
                          jsonDecode(prefs!.getString('userDetails')!)[
                                      'work_experience'] !=
                                  null
                              ? ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: jsonDecode(prefs!.getString(
                                          'userDetails')!)['work_experience']
                                      .length,
                                  itemBuilder: (context, index) {
                                    return ProfileComponents()
                                        .workExperienceDetailCard(
                                      companyName: jsonDecode(prefs!
                                                  .getString('userDetails')!)[
                                              'work_experience'][index]
                                          ['compnay_name'],
                                      jobTitle: jsonDecode(prefs!
                                                  .getString('userDetails')!)[
                                              'work_experience'][index]
                                          ['job_title'],
                                      from: jsonDecode(prefs!
                                                  .getString('userDetails')!)[
                                              'work_experience'][index]
                                          ['date_from'],
                                      to: jsonDecode(prefs!.getString(
                                                      'userDetails')!)[
                                                  'work_experience'][index]
                                              ['date_to'] ??
                                          'Till Now',
                                    );
                                  },
                                )
                              : Container(),
                        ],
                      ),
                    ),
                  ),
                  //Education
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Card(
                      margin: EdgeInsets.zero,
                      color: AppColor.placeholderBg,
                      elevation: 2,
                      shadowColor: AppColor.placeholder.withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            horizontalTitleGap: 0,
                            leading: SvgPicture.asset(
                              Kimages.educationIcon,
                              width: 20,
                              height: 20,
                              color: AppColor.primaryColor,
                            ),
                            title: Text(
                              'Education',
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColor.blackColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Divider(
                            color: AppColor.placeholder,
                          ),
                          jsonDecode(prefs!.getString('userDetails')!)[
                                      'educations'] !=
                                  null
                              ? ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: jsonDecode(prefs!.getString(
                                          'userDetails')!)['educations']
                                      .length,
                                  itemBuilder: (context, index) {
                                    return ProfileComponents()
                                        .educationDetailCard(
                                      degreeTitle: jsonDecode(
                                              prefs!.getString('userDetails')!)[
                                          'educations'][index]['course'],
                                      from: jsonDecode(
                                              prefs!.getString('userDetails')!)[
                                          'educations'][index]['from'],
                                      score: jsonDecode(prefs!.getString(
                                                  'userDetails')!)['educations']
                                              [index]['score'] +
                                          '/' +
                                          jsonDecode(prefs!.getString(
                                                  'userDetails')!)['educations']
                                              [index]['scale'],
                                      to: jsonDecode(
                                              prefs!.getString('userDetails')!)[
                                          'educations'][index]['to'],
                                      uniName: jsonDecode(
                                              prefs!.getString('userDetails')!)[
                                          'educations'][index]['institute'],
                                    );
                                  },
                                )
                              : Container(),
                        ],
                      ),
                    ),
                  ),
                  //Projects
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Card(
                      margin: EdgeInsets.zero,
                      color: AppColor.placeholderBg,
                      elevation: 2,
                      shadowColor: AppColor.placeholder.withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            horizontalTitleGap: 0,
                            leading: SvgPicture.asset(
                              Kimages.projectsIcon,
                              width: 20,
                              height: 20,
                              color: AppColor.primaryColor,
                            ),
                            title: Text(
                              'Projects',
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColor.blackColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Divider(
                            color: AppColor.placeholder,
                          ),
                          jsonDecode(prefs!.getString('userDetails')!)[
                                      'certificate'] !=
                                  null
                              ? ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: jsonDecode(prefs!.getString(
                                          'userDetails')!)['certificate']
                                      .length,
                                  itemBuilder: (context, index) {
                                    return ProfileComponents()
                                        .projectsDetailsCard(
                                      from: jsonDecode(
                                              prefs!.getString('userDetails')!)[
                                          'projects'][index]['from'],
                                      projectTitle: jsonDecode(
                                              prefs!.getString('userDetails')!)[
                                          'projects'][index]['project_name'],
                                      role: jsonDecode(
                                              prefs!.getString('userDetails')!)[
                                          'projects'][index]['your_role'],
                                      to: jsonDecode(
                                              prefs!.getString('userDetails')!)[
                                          'projects'][index]['to'],
                                      url: jsonDecode(
                                              prefs!.getString('userDetails')!)[
                                          'projects'][index]['project_url'],
                                    );
                                  },
                                )
                              : Container(),
                          ProfileComponents().projectsDetailsCard(
                            from: 'Sep, 2021',
                            projectTitle: 'Job Aid Mobile App',
                            role: 'Developer',
                            to: 'Till Now',
                            url: '',
                          ),
                        ],
                      ),
                    ),
                  ),
                  //Certificates
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Card(
                      margin: EdgeInsets.zero,
                      color: AppColor.placeholderBg,
                      elevation: 2,
                      shadowColor: AppColor.placeholder.withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            horizontalTitleGap: 0,
                            leading: SvgPicture.asset(
                              Kimages.certificationIcon,
                              width: 20,
                              height: 20,
                              color: AppColor.primaryColor,
                            ),
                            title: Text(
                              'Certificates',
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColor.blackColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Divider(
                            color: AppColor.placeholder,
                          ),
                          jsonDecode(prefs!.getString('userDetails')!)[
                                      'certificate'] !=
                                  null
                              ? ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: jsonDecode(prefs!.getString(
                                          'userDetails')!)['certificate']
                                      .length,
                                  itemBuilder: (context, index) {
                                    return ProfileComponents()
                                        .certificateDetailCard(
                                      certificateTitle: jsonDecode(
                                              prefs!.getString('userDetails')!)[
                                          'certificate'][index]['title'],
                                      companyName: jsonDecode(prefs!.getString(
                                              'userDetails')!)['certificate']
                                          [index]['publishing_organization'],
                                      from: jsonDecode(prefs!.getString(
                                              'userDetails')!)['certificate']
                                          [index]['date_of_issue'],
                                    );
                                  },
                                )
                              : Container(),
                        ],
                      ),
                    ),
                  ),
                  //Language
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Card(
                      margin: EdgeInsets.zero,
                      color: AppColor.placeholderBg,
                      elevation: 2,
                      shadowColor: AppColor.placeholder.withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            horizontalTitleGap: 0,
                            leading: SvgPicture.asset(
                              Kimages.languageIcon,
                              width: 20,
                              height: 20,
                              color: AppColor.primaryColor,
                            ),
                            title: Text(
                              'Languages',
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColor.blackColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Divider(
                            color: AppColor.placeholder,
                          ),
                          jsonDecode(prefs!.getString('userDetails')!)[
                                      'languages'] !=
                                  null
                              ? ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: jsonDecode(prefs!.getString(
                                          'userDetails')!)['languages']
                                      .length,
                                  itemBuilder: (context, index) {
                                    return ProfileComponents()
                                        .languageDetailCard(
                                      languageTitle: jsonDecode(
                                              prefs!.getString('userDetails')!)[
                                          'languages'][index]['language'],
                                      proficiency: jsonDecode(
                                              prefs!.getString('userDetails')!)[
                                          'languages'][index]['proficiency'],
                                    );
                                  },
                                )
                              : Container(),
                        ],
                      ),
                    ),
                  ),
                  //Skills
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Card(
                      margin: EdgeInsets.zero,
                      color: AppColor.placeholderBg,
                      elevation: 2,
                      shadowColor: AppColor.placeholder.withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            horizontalTitleGap: 0,
                            leading: SvgPicture.asset(
                              Kimages.skillIcon,
                              width: 20,
                              height: 20,
                              color: AppColor.primaryColor,
                            ),
                            title: Text(
                              'Skills',
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColor.blackColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Divider(
                            color: AppColor.placeholder,
                          ),
                          jsonDecode(prefs!.getString('userDetails')!)[
                                      'skills'] !=
                                  null
                              ? SizedBox(
                                  height: 40,
                                  child: ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount: jsonDecode(prefs!.getString(
                                            'userDetails')!)['skills']
                                        .length,
                                    itemBuilder: (context, index) {
                                      return Card(
                                        margin: EdgeInsets.all(5),
                                        color: AppColor.transparent,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          side: BorderSide(
                                              color: AppColor.primaryColor
                                                  .withOpacity(0.5)),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            jsonDecode(prefs!.getString(
                                                    'userDetails')!)['skills']
                                                [index],
                                            style: TextStyle(
                                              color: AppColor.primaryColor,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    ),
                  ),
                  //CV-Resume
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Card(
                      margin: EdgeInsets.zero,
                      color: AppColor.placeholderBg,
                      elevation: 2,
                      shadowColor: AppColor.placeholder.withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            horizontalTitleGap: 0,
                            leading: SvgPicture.asset(
                              Kimages.projectsIcon,
                              width: 20,
                              height: 20,
                              color: AppColor.primaryColor,
                            ),
                            title: Text(
                              'CV/Resume',
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColor.blackColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Divider(
                            color: AppColor.placeholder,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ListTile(
                              leading: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColor.transparent,
                                ),
                                child: SvgPicture.asset(Kimages.pdfIcon),
                              ),
                              title: Text(
                                'My CV.pdf',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppColor.blackColor,
                                ),
                              ),
                              subtitle: Text(
                                jsonDecode(prefs!.getString('userDetails')!)[
                                    'cv_size'],
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColor.blackColor.withOpacity(0.5),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 65,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(AppColor.primaryColor),
            foregroundColor: MaterialStateProperty.all<Color>(AppColor.white),
            overlayColor: MaterialStateProperty.all<Color>(
                AppColor.primary.withOpacity(0.1)),
            minimumSize: MaterialStateProperty.all(
              Size(MediaQuery.of(context).size.width, 45),
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          onPressed: () async {
            Components.showAlertDialog(context);
            await FirebaseFirestore.instance
                .collection('job_application')
                .doc()
                .set({
              'job_id': jobId,
              'user_id': user.uid,
              'posted_by': postedBy,
              'status': 'Sent'
            }).whenComplete(() async {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              Components.showSnackBar(
                  context, 'Application Submitted Successfully');
            }).catchError((e) {
              Navigator.of(context).pop();
              Components.showSnackBar(context, e.toString());
            });
          },
          child: Text('Apply'),
        ),
      ),
    );
  }
}
