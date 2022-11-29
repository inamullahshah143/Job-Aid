import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:get/get.dart';
import 'package:job_aid/constants/colors.dart';
import 'package:job_aid/constants/k_images.dart';
import 'package:job_aid/screens/candidate_home/components/profile_components.dart';
import 'package:job_aid/screens/chat/chat_room.dart';

import '../controller/job_application_controller.dart';

class ApplicantDetails extends StatelessWidget {
  final Map<String, dynamic> userDetails;
  final String applicationsStatus;
  final String userId;
  final String applicationId;
  const ApplicantDetails({
    super.key,
    required this.userDetails,
    required this.applicationsStatus,
    required this.userId,
    required this.applicationId,
  });

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
        actions: [
          IconButton(
            padding: EdgeInsets.zero,
            onPressed: () async {
              Get.to(
                ChatRoom(
                  phoneNo: userDetails['phone_no'],
                  userId: userId,
                  username: userDetails['name'],
                  profilePicture: userDetails['profile_picture'],
                ),
              );
            },
            icon: Icon(FontAwesome.chat_empty),
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              JobApplicationController()
                  .updateApplicationStatus(applicationId, value, context);
            },
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  child: Text('Approved'),
                  value: 'Approved',
                ),
                PopupMenuItem(
                  child: Text('Rejected'),
                  value: 'Rejected',
                ),
                PopupMenuItem(
                  child: Text('Pending'),
                  value: 'Pending',
                ),
              ];
            },
          ),
        ],
        title: Text(
          'Applicant Details',
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
                  userDetails['profile_picture'],
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text(
            userDetails['name'],
            style: TextStyle(
              fontSize: 24,
              height: 2.5,
              color: AppColor.primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            userDetails['experties'],
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
                              userDetails['complete_address'] +
                                  ', ' +
                                  userDetails['city'] +
                                  ', ' +
                                  userDetails['province'],
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
                              userDetails['phone_no'],
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
                              userDetails['email'],
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
                              userDetails['about'],
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
                                    text: userDetails['expected_salary']
                                            ['currency'] +
                                        ' ' +
                                        userDetails['expected_salary']
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
                                    text: userDetails['expected_salary']
                                            ['currency'] +
                                        ' ' +
                                        userDetails['expected_salary']
                                            ['maximum_salary'],
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: AppColor.blackColor,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        ' ${userDetails['expected_salary']['frequency']}',
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
                          userDetails['work_experience'] != null
                              ? ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount:
                                      userDetails['work_experience'].length,
                                  itemBuilder: (context, index) {
                                    return ProfileComponents()
                                        .workExperienceDetailCard(
                                      companyName:
                                          userDetails['work_experience'][index]
                                              ['compnay_name'],
                                      jobTitle: userDetails['work_experience']
                                          [index]['job_title'],
                                      from: userDetails['work_experience']
                                          [index]['date_from'],
                                      to: userDetails['work_experience'][index]
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
                          userDetails['educations'] != null
                              ? ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: userDetails['educations'].length,
                                  itemBuilder: (context, index) {
                                    return ProfileComponents()
                                        .educationDetailCard(
                                      degreeTitle: userDetails['educations']
                                          [index]['course'],
                                      from: userDetails['educations'][index]
                                          ['from'],
                                      score: userDetails['educations'][index]
                                              ['score'] +
                                          '/' +
                                          userDetails['educations'][index]
                                              ['scale'],
                                      to: userDetails['educations'][index]
                                          ['to'],
                                      uniName: userDetails['educations'][index]
                                          ['institute'],
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
                          userDetails['certificate'] != null
                              ? ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: userDetails['certificate'].length,
                                  itemBuilder: (context, index) {
                                    return ProfileComponents()
                                        .projectsDetailsCard(
                                      from: userDetails['projects'][index]
                                          ['from'],
                                      projectTitle: userDetails['projects']
                                          [index]['project_name'],
                                      role: userDetails['projects'][index]
                                          ['your_role'],
                                      to: userDetails['projects'][index]['to'],
                                      url: userDetails['projects'][index]
                                          ['project_url'],
                                    );
                                  },
                                )
                              : Container(),
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
                          userDetails['certificate'] != null
                              ? ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: userDetails['certificate'].length,
                                  itemBuilder: (context, index) {
                                    return ProfileComponents()
                                        .certificateDetailCard(
                                      certificateTitle:
                                          userDetails['certificate'][index]
                                              ['title'],
                                      companyName: userDetails['certificate']
                                          [index]['publishing_organization'],
                                      from: userDetails['certificate'][index]
                                          ['date_of_issue'],
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
                          userDetails['languages'] != null
                              ? ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: userDetails['languages'].length,
                                  itemBuilder: (context, index) {
                                    return ProfileComponents()
                                        .languageDetailCard(
                                      languageTitle: userDetails['languages']
                                          [index]['language'],
                                      proficiency: userDetails['languages']
                                          [index]['proficiency'],
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
                          userDetails['skills'] != null
                              ? SizedBox(
                                  height: 40,
                                  child: ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount: userDetails['skills'].length,
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
                                            userDetails['skills'][index],
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
                              trailing: IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.download),
                              ),
                              title: Text(
                                'My CV.pdf',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppColor.blackColor,
                                ),
                              ),
                              subtitle: Text(
                                userDetails['cv_size'],
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
