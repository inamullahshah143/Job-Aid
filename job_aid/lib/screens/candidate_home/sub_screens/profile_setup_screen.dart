import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:job_aid/auth/splash_screen.dart';
import 'package:job_aid/constants/colors.dart';
import 'package:job_aid/constants/components.dart';
import 'package:job_aid/constants/k_images.dart';
import 'package:job_aid/main.dart';
import 'package:job_aid/screens/candidate_home/sub_screens/profile_sub/add_certificate.dart';
import 'package:job_aid/screens/candidate_home/sub_screens/profile_sub/add_education.dart';
import 'package:job_aid/screens/candidate_home/sub_screens/profile_sub/add_language.dart';
import 'package:job_aid/screens/candidate_home/sub_screens/profile_sub/add_projects.dart';
import 'package:job_aid/screens/candidate_home/sub_screens/profile_sub/add_skills.dart';
import 'package:job_aid/screens/candidate_home/sub_screens/profile_sub/add_work_experience.dart';
import 'package:job_aid/utils/auth_helper.dart';

import 'package:csc_picker/csc_picker.dart';
import '../components/profile_components.dart';

class ProfileSetupScreen extends StatefulWidget {
  ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final String initialCountry = 'PK';

  final PhoneNumber number = PhoneNumber(
    phoneNumber: jsonDecode(prefs!.getString('userDetails')!)['phone_no'],
    isoCode: '+92',
  );

  final isValidNo = true.obs;

  Map<String, dynamic> expectedSalary = {};

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
          'Profile',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          ListTile(
            leading: Container(
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
            title: Text(
              jsonDecode(prefs!.getString('userDetails')!)['name'],
              style: TextStyle(
                fontSize: 18,
                height: 1.25,
                color: AppColor.primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text(
              jsonDecode(prefs!.getString('userDetails')!)['experties'],
              style: TextStyle(
                fontSize: 12,
                color: AppColor.blackColor,
                fontWeight: FontWeight.w200,
              ),
            ),
            trailing: IconButton(
              onPressed: () {},
              icon: Icon(
                FontAwesome5.edit,
                size: 16,
                color: AppColor.primaryColor,
              ),
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
                  ExpansionTile(
                    expandedCrossAxisAlignment: CrossAxisAlignment.start,
                    leading: SvgPicture.asset(
                      Kimages.contactIcon,
                      width: 20,
                      height: 20,
                    ),
                    title: Text('Contact Infromation'),
                    maintainState: true,
                    childrenPadding: EdgeInsets.all(25),
                    collapsedIconColor: AppColor.blackColor,
                    iconColor: AppColor.primaryColor,
                    children: [
                      Form(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Address',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: AppColor.blackColor,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            CSCPicker(
                              currentCity:  jsonDecode(prefs!.getString('userDetails')!)[
                                      'city'],
                              currentCountry:  jsonDecode(prefs!.getString('userDetails')!)[
                                      'country'],
                              currentState:  jsonDecode(prefs!.getString('userDetails')!)[
                                      'province'],
                              defaultCountry: DefaultCountry.Pakistan,
                              dropdownDecoration: BoxDecoration(),
                              disabledDropdownDecoration: BoxDecoration(),
                              showStates: true,
                              showCities: true,
                              flagState: CountryFlag.SHOW_IN_DROP_DOWN_ONLY,
                              countrySearchPlaceholder: "Country",
                              stateSearchPlaceholder: "State",
                              citySearchPlaceholder: "City",
                              countryDropdownLabel: "Country",
                              stateDropdownLabel: "State",
                              cityDropdownLabel: "City",
                              selectedItemStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                              dropdownHeadingStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                              dropdownItemStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                              dropdownDialogRadius: 10.0,
                              searchBarRadius: 10.0,
                              onCountryChanged: (value) {},
                              onStateChanged: (value) {},
                              onCityChanged: (value) {},
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              initialValue:
                                  jsonDecode(prefs!.getString('userDetails')!)[
                                      'complete_address'],
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.text,
                              minLines: 5,
                              maxLines: 6,
                              style: TextStyle(
                                color: AppColor.blackColor,
                                fontSize: 14,
                              ),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor:
                                    AppColor.placeholder.withOpacity(0.15),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: const EdgeInsets.all(12.5),
                                hintText: 'Postal Address',
                                hintStyle: TextStyle(
                                  color: AppColor.placeholder,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Phone No',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: AppColor.blackColor,
                                ),
                              ),
                            ),
                            InternationalPhoneNumberInput(
                              onInputChanged: (PhoneNumber number) {},
                              onInputValidated: (bool value) {
                                isValidNo.value = value;
                              },
                              textStyle: TextStyle(
                                color: AppColor.blackColor,
                                fontSize: 14,
                              ),
                              selectorConfig: const SelectorConfig(
                                trailingSpace: false,
                                setSelectorButtonAsPrefixIcon: true,
                                showFlags: false,
                                selectorType: PhoneInputSelectorType.DIALOG,
                              ),
                              ignoreBlank: false,
                              autoValidateMode: AutovalidateMode.disabled,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'please enter your phone number';
                                } else if (isValidNo.value == false) {
                                  return 'please enter valid phone number';
                                } else {
                                  return null;
                                }
                              },
                              selectorTextStyle:
                                  const TextStyle(color: Colors.black),
                              initialValue: number,
                              formatInput: false,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      signed: true, decimal: true),
                              inputDecoration: InputDecoration(
                                filled: true,
                                fillColor:
                                    AppColor.placeholder.withOpacity(0.15),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: const EdgeInsets.all(12.5),
                                hintText: 'Phone No.',
                                hintStyle: TextStyle(
                                  color: AppColor.placeholder,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Email',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: AppColor.blackColor,
                                ),
                              ),
                            ),
                            TextFormField(
                              initialValue: jsonDecode(
                                  prefs!.getString('userDetails')!)['email'],
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyle(
                                color: AppColor.blackColor,
                                fontSize: 14,
                              ),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor:
                                    AppColor.placeholder.withOpacity(0.15),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: const EdgeInsets.all(12.5),
                                hintText: 'Email Address',
                                hintStyle: TextStyle(
                                  color: AppColor.placeholder,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        AppColor.primaryColor),
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        AppColor.white),
                                overlayColor: MaterialStateProperty.all<Color>(
                                    AppColor.primary.withOpacity(0.1)),
                                minimumSize: MaterialStateProperty.all(
                                  Size(MediaQuery.of(context).size.width, 45),
                                ),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                              onPressed: () {},
                              child: const Text("Update Contacts Info"),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  //Summary
                  ExpansionTile(
                    expandedCrossAxisAlignment: CrossAxisAlignment.start,
                    childrenPadding: EdgeInsets.all(25),
                    leading: SvgPicture.asset(
                      Kimages.summaryIcon,
                      width: 20,
                      height: 20,
                    ),
                    title: Text('Summary'),
                    maintainState: true,
                    collapsedIconColor: AppColor.blackColor,
                    iconColor: AppColor.primaryColor,
                    children: [
                      Form(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: const Text(
                                '*Summary (Max 500 characters)',
                                style: TextStyle(
                                  color: AppColor.blackColor,
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                            TextFormField(
                              initialValue: jsonDecode(
                                  prefs!.getString('userDetails')!)['about'],
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.text,
                              minLines: 10,
                              maxLines: 15,
                              maxLength: 500,
                              style: TextStyle(
                                color: AppColor.blackColor,
                                fontSize: 14,
                              ),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor:
                                    AppColor.placeholder.withOpacity(0.15),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: const EdgeInsets.all(12.5),
                                hintText: 'Summary',
                                hintStyle: TextStyle(
                                  color: AppColor.placeholder,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        AppColor.primaryColor),
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        AppColor.white),
                                overlayColor: MaterialStateProperty.all<Color>(
                                    AppColor.primary.withOpacity(0.1)),
                                minimumSize: MaterialStateProperty.all(
                                  Size(MediaQuery.of(context).size.width, 45),
                                ),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                              onPressed: () {},
                              child: const Text("Update Summary"),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  //Expected Salary
                  ExpansionTile(
                    leading: SvgPicture.asset(
                      Kimages.salaryIcon,
                      width: 20,
                      height: 20,
                    ),
                    title: Text('Expected Salary'),
                    maintainState: true,
                    collapsedIconColor: AppColor.blackColor,
                    iconColor: AppColor.primaryColor,
                    expandedCrossAxisAlignment: CrossAxisAlignment.start,
                    childrenPadding: EdgeInsets.all(25),
                    children: [
                      Form(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              initialValue:
                                  jsonDecode(prefs!.getString('userDetails')!)[
                                              'expected_salary'] !=
                                          null
                                      ? jsonDecode(
                                              prefs!.getString('userDetails')!)[
                                          'expected_salary']['minimum_salary']
                                      : '',
                              onChanged: (value) {
                                expectedSalary['minimum_salary'] = value;
                              },
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                color: AppColor.blackColor,
                                fontSize: 14,
                              ),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor:
                                    AppColor.placeholder.withOpacity(0.15),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: const EdgeInsets.all(12.5),
                                hintText: 'Minimum Salary',
                                hintStyle: TextStyle(
                                  color: AppColor.placeholder,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              initialValue:
                                  jsonDecode(prefs!.getString('userDetails')!)[
                                              'expected_salary'] !=
                                          null
                                      ? jsonDecode(
                                              prefs!.getString('userDetails')!)[
                                          'expected_salary']['maximum_salary']
                                      : '',
                              onChanged: (value) {
                                expectedSalary['maximum_salary'] = value;
                              },
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                color: AppColor.blackColor,
                                fontSize: 14,
                              ),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor:
                                    AppColor.placeholder.withOpacity(0.15),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: const EdgeInsets.all(12.5),
                                hintText: 'Maximum Salary',
                                hintStyle: TextStyle(
                                  color: AppColor.placeholder,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            DropdownButtonFormField(
                              value:
                                  jsonDecode(prefs!.getString('userDetails')!)[
                                              'expected_salary'] !=
                                          null
                                      ? jsonDecode(
                                              prefs!.getString('userDetails')!)[
                                          'expected_salary']['currency']
                                      : null,
                              onChanged: (value) {
                                expectedSalary['currency'] = value;
                              },
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColor.blackColor,
                              ),
                              items: [
                                DropdownMenuItem(
                                  value: 'USD',
                                  child: Text('USD'),
                                ),
                                DropdownMenuItem(
                                  value: 'PKR',
                                  child: Text('PKR'),
                                ),
                              ],
                              isDense: true,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor:
                                    AppColor.placeholder.withOpacity(0.15),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: const EdgeInsets.all(12.5),
                                hintText: 'Currency',
                                isDense: true,
                                hintStyle: TextStyle(
                                  color: AppColor.placeholder,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            DropdownButtonFormField(
                              value:
                                  jsonDecode(prefs!.getString('userDetails')!)[
                                              'expected_salary'] !=
                                          null
                                      ? jsonDecode(
                                              prefs!.getString('userDetails')!)[
                                          'expected_salary']['frequency']
                                      : null,
                              onChanged: (value) {
                                expectedSalary['frequency'] = value;
                              },
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColor.blackColor,
                              ),
                              items: [
                                DropdownMenuItem(
                                  value: 'Per Hour',
                                  child: Text('Per Hour'),
                                ),
                                DropdownMenuItem(
                                  value: 'Per Day',
                                  child: Text('Per Day'),
                                ),
                                DropdownMenuItem(
                                  value: 'Per Week',
                                  child: Text('Per Week'),
                                ),
                                DropdownMenuItem(
                                  value: 'Per Month',
                                  child: Text('Per Month'),
                                ),
                                DropdownMenuItem(
                                  value: 'Quartile',
                                  child: Text('Quartile'),
                                ),
                                DropdownMenuItem(
                                  value: 'Yearly',
                                  child: Text('Yearly'),
                                ),
                              ],
                              isDense: true,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor:
                                    AppColor.placeholder.withOpacity(0.15),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: const EdgeInsets.all(12.5),
                                hintText: 'Frequency',
                                isDense: true,
                                hintStyle: TextStyle(
                                  color: AppColor.placeholder,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        AppColor.primaryColor),
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        AppColor.white),
                                overlayColor: MaterialStateProperty.all<Color>(
                                    AppColor.primary.withOpacity(0.1)),
                                minimumSize: MaterialStateProperty.all(
                                  Size(MediaQuery.of(context).size.width, 45),
                                ),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                              onPressed: () async {
                                Components.showAlertDialog(context);
                                await FirebaseFirestore.instance
                                    .collection('user_record')
                                    .doc(user.uid)
                                    .update({
                                  'expected_salary': expectedSalary
                                }).then((userData) async {
                                  Map<String, dynamic> updateUserData =
                                      jsonDecode(
                                          prefs!.getString('userDetails')!);
                                  updateUserData['expected_salary'] =
                                      expectedSalary;
                                  prefs!.setString('userDetails',
                                      jsonEncode(updateUserData));
                                  Navigator.of(context).pop();
                                  setState(() {});
                                  Components.showSnackBar(
                                      context, 'Record Updated Successfully');
                                }).catchError((e) {
                                  Navigator.of(context).pop();
                                  Components.showSnackBar(
                                      context, e.toString());
                                });
                              },
                              child: const Text("Update Expected Salary"),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  //Work Experience
                  ExpansionTile(
                    leading: SvgPicture.asset(
                      Kimages.experienceIcon,
                      width: 20,
                      height: 20,
                    ),
                    title: Text('Work Experience'),
                    maintainState: true,
                    collapsedIconColor: AppColor.blackColor,
                    iconColor: AppColor.primaryColor,
                    expandedCrossAxisAlignment: CrossAxisAlignment.start,
                    childrenPadding: EdgeInsets.all(25),
                    children: [
                      Form(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            jsonDecode(prefs!.getString('userDetails')!)[
                                        'work_experience'] !=
                                    null
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: jsonDecode(prefs!.getString(
                                            'userDetails')!)['work_experience']
                                        .length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ProfileComponents()
                                            .workExperienceCard(
                                          companyName: jsonDecode(prefs!
                                                      .getString(
                                                          'userDetails')!)[
                                                  'work_experience'][index]
                                              ['compnay_name'],
                                          jobTitle: jsonDecode(prefs!.getString(
                                                      'userDetails')!)[
                                                  'work_experience'][index]
                                              ['job_title'],
                                          from: jsonDecode(prefs!.getString(
                                                      'userDetails')!)[
                                                  'work_experience'][index]
                                              ['date_from'],
                                          to: jsonDecode(prefs!.getString(
                                                          'userDetails')!)[
                                                      'work_experience'][index]
                                                  ['date_to'] ??
                                              'Till Now',
                                        ),
                                      );
                                    },
                                  )
                                : Container(),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: const Text(
                                '*Add your Work Experience',
                                style: TextStyle(
                                  color: AppColor.blackColor,
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        AppColor.primaryColor),
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        AppColor.white),
                                overlayColor: MaterialStateProperty.all<Color>(
                                    AppColor.primary.withOpacity(0.1)),
                                minimumSize: MaterialStateProperty.all(
                                  Size(MediaQuery.of(context).size.width, 45),
                                ),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                Get.to(AddWorkExperience());
                              },
                              child: const Text("Add Work Experience"),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  //Education
                  ExpansionTile(
                    leading: SvgPicture.asset(
                      Kimages.educationIcon,
                      width: 20,
                      height: 20,
                    ),
                    title: Text('Education'),
                    maintainState: true,
                    collapsedIconColor: AppColor.blackColor,
                    iconColor: AppColor.primaryColor,
                    expandedCrossAxisAlignment: CrossAxisAlignment.start,
                    childrenPadding: EdgeInsets.all(25),
                    children: [
                      Form(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            jsonDecode(prefs!.getString('userDetails')!)[
                                        'educations'] !=
                                    null
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: jsonDecode(prefs!.getString(
                                            'userDetails')!)['educations']
                                        .length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child:
                                            ProfileComponents().educationCard(
                                          degreeTitle: jsonDecode(prefs!
                                                  .getString('userDetails')!)[
                                              'educations'][index]['course'],
                                          from: jsonDecode(prefs!.getString(
                                                  'userDetails')!)['educations']
                                              [index]['from'],
                                          score: jsonDecode(prefs!.getString(
                                                          'userDetails')!)[
                                                      'educations'][index]
                                                  ['score'] +
                                              '/' +
                                              jsonDecode(prefs!.getString(
                                                      'userDetails')!)[
                                                  'educations'][index]['scale'],
                                          to: jsonDecode(prefs!.getString(
                                                  'userDetails')!)['educations']
                                              [index]['to'],
                                          uniName: jsonDecode(prefs!.getString(
                                                  'userDetails')!)['educations']
                                              [index]['institute'],
                                        ),
                                      );
                                    },
                                  )
                                : Container(),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: const Text(
                                '*Add your Education',
                                style: TextStyle(
                                  color: AppColor.blackColor,
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        AppColor.primaryColor),
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        AppColor.white),
                                overlayColor: MaterialStateProperty.all<Color>(
                                    AppColor.primary.withOpacity(0.1)),
                                minimumSize: MaterialStateProperty.all(
                                  Size(MediaQuery.of(context).size.width, 45),
                                ),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                Get.to(AddEducation());
                              },
                              child: const Text("Add Education"),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  //Projects
                  ExpansionTile(
                    leading: SvgPicture.asset(
                      Kimages.projectsIcon,
                      width: 20,
                      height: 20,
                    ),
                    title: Text('Projects'),
                    maintainState: true,
                    collapsedIconColor: AppColor.blackColor,
                    iconColor: AppColor.primaryColor,
                    expandedCrossAxisAlignment: CrossAxisAlignment.start,
                    childrenPadding: EdgeInsets.all(25),
                    children: [
                      Form(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            jsonDecode(prefs!.getString('userDetails')!)[
                                        'projects'] !=
                                    null
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: jsonDecode(prefs!.getString(
                                            'userDetails')!)['projects']
                                        .length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ProfileComponents().projectsCard(
                                          from: jsonDecode(prefs!.getString(
                                                  'userDetails')!)['projects']
                                              [index]['from'],
                                          projectTitle: jsonDecode(prefs!
                                                      .getString(
                                                          'userDetails')!)[
                                                  'projects'][index]
                                              ['project_name'],
                                          role: jsonDecode(prefs!.getString(
                                                  'userDetails')!)['projects']
                                              [index]['your_role'],
                                          to: jsonDecode(prefs!.getString(
                                                  'userDetails')!)['projects']
                                              [index]['to'],
                                          url: jsonDecode(prefs!.getString(
                                                  'userDetails')!)['projects']
                                              [index]['project_url'],
                                        ),
                                      );
                                    },
                                  )
                                : Container(),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: const Text(
                                '*Add your Projects',
                                style: TextStyle(
                                  color: AppColor.blackColor,
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        AppColor.primaryColor),
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        AppColor.white),
                                overlayColor: MaterialStateProperty.all<Color>(
                                    AppColor.primary.withOpacity(0.1)),
                                minimumSize: MaterialStateProperty.all(
                                  Size(MediaQuery.of(context).size.width, 45),
                                ),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                Get.to(AddProjects());
                              },
                              child: const Text("Add Projects"),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  //Certificates
                  ExpansionTile(
                    leading: SvgPicture.asset(
                      Kimages.certificationIcon,
                      width: 20,
                      height: 20,
                    ),
                    title: Text('Certificates'),
                    maintainState: true,
                    collapsedIconColor: AppColor.blackColor,
                    iconColor: AppColor.primaryColor,
                    expandedCrossAxisAlignment: CrossAxisAlignment.start,
                    childrenPadding: EdgeInsets.all(25),
                    children: [
                      Form(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            jsonDecode(prefs!.getString('userDetails')!)[
                                        'certificate'] !=
                                    null
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: jsonDecode(prefs!.getString(
                                            'userDetails')!)['certificate']
                                        .length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child:
                                            ProfileComponents().certificateCard(
                                          certificateTitle: jsonDecode(prefs!
                                                  .getString('userDetails')!)[
                                              'certificate'][index]['title'],
                                          companyName: jsonDecode(prefs!
                                                      .getString(
                                                          'userDetails')!)[
                                                  'certificate'][index]
                                              ['publishing_organization'],
                                          from: jsonDecode(prefs!.getString(
                                                      'userDetails')!)[
                                                  'certificate'][index]
                                              ['date_of_issue'],
                                        ),
                                      );
                                    },
                                  )
                                : Container(),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: const Text(
                                '*Add your Certificates',
                                style: TextStyle(
                                  color: AppColor.blackColor,
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        AppColor.primaryColor),
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        AppColor.white),
                                overlayColor: MaterialStateProperty.all<Color>(
                                    AppColor.primary.withOpacity(0.1)),
                                minimumSize: MaterialStateProperty.all(
                                  Size(MediaQuery.of(context).size.width, 45),
                                ),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                Get.to(AddCertificate());
                              },
                              child: const Text("Add Certificates"),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  //Languages
                  ExpansionTile(
                    leading: SvgPicture.asset(
                      Kimages.languageIcon,
                      width: 20,
                      height: 20,
                    ),
                    title: Text('Languages'),
                    maintainState: true,
                    collapsedIconColor: AppColor.blackColor,
                    iconColor: AppColor.primaryColor,
                    expandedCrossAxisAlignment: CrossAxisAlignment.start,
                    childrenPadding: EdgeInsets.all(25),
                    children: [
                      Form(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            jsonDecode(prefs!.getString('userDetails')!)[
                                        'languages'] !=
                                    null
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: jsonDecode(prefs!.getString(
                                            'userDetails')!)['languages']
                                        .length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ProfileComponents().languageCard(
                                          languageTitle: jsonDecode(prefs!
                                                  .getString('userDetails')!)[
                                              'languages'][index]['language'],
                                          proficiency: jsonDecode(prefs!
                                                      .getString(
                                                          'userDetails')!)[
                                                  'languages'][index]
                                              ['proficiency'],
                                        ),
                                      );
                                    },
                                  )
                                : Container(),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: const Text(
                                '*Add your Languages',
                                style: TextStyle(
                                  color: AppColor.blackColor,
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        AppColor.primaryColor),
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        AppColor.white),
                                overlayColor: MaterialStateProperty.all<Color>(
                                    AppColor.primary.withOpacity(0.1)),
                                minimumSize: MaterialStateProperty.all(
                                  Size(MediaQuery.of(context).size.width, 45),
                                ),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                Get.to(AddLanguage());
                              },
                              child: const Text("Add Languages"),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  //Skills
                  ExpansionTile(
                    leading: SvgPicture.asset(
                      Kimages.skillIcon,
                      width: 20,
                      height: 20,
                    ),
                    title: Text('Skills'),
                    maintainState: true,
                    collapsedIconColor: AppColor.blackColor,
                    iconColor: AppColor.primaryColor,
                    expandedCrossAxisAlignment: CrossAxisAlignment.start,
                    childrenPadding: EdgeInsets.all(25),
                    children: [
                      Form(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            jsonDecode(prefs!.getString('userDetails')!)[
                                        'skills'] !=
                                    null
                                ? SizedBox(
                                    height: 40,
                                    child: ListView.builder(
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
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: const Text(
                                '*Add your Skills',
                                style: TextStyle(
                                  color: AppColor.blackColor,
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        AppColor.primaryColor),
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        AppColor.white),
                                overlayColor: MaterialStateProperty.all<Color>(
                                    AppColor.primary.withOpacity(0.1)),
                                minimumSize: MaterialStateProperty.all(
                                  Size(MediaQuery.of(context).size.width, 45),
                                ),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                Get.to(AddSkills());
                              },
                              child: const Text("Add Skills"),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  //CV-Resume
                  ExpansionTile(
                    leading: SvgPicture.asset(
                      Kimages.cvIcon,
                      width: 20,
                      height: 20,
                    ),
                    title: Text('CV/Resume'),
                    maintainState: true,
                    collapsedIconColor: AppColor.blackColor,
                    iconColor: AppColor.primaryColor,
                    expandedCrossAxisAlignment: CrossAxisAlignment.start,
                    childrenPadding: EdgeInsets.all(25),
                    children: [
                      Form(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        AppColor.primaryColor),
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        AppColor.white),
                                overlayColor: MaterialStateProperty.all<Color>(
                                    AppColor.primary.withOpacity(0.1)),
                                minimumSize: MaterialStateProperty.all(
                                  Size(MediaQuery.of(context).size.width, 45),
                                ),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                              onPressed: () {},
                              child: const Text("Update CV/Resume"),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  //Logout
                  ListTile(
                    onTap: () {
                      Components.showAlertDialog(context);
                      AuthenticationHelper().signOut().whenComplete(() {
                        prefs!.setString('userDetails', '');
                        Get.offAll(SplashScreen());
                      });
                    },
                    textColor: Colors.red,
                    leading: SvgPicture.asset(
                      Kimages.logoutIcon,
                      color: Colors.red,
                      width: 20,
                      height: 20,
                    ),
                    title: Text('Logout'),
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
