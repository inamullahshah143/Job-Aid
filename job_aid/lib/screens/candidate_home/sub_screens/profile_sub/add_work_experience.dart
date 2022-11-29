import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:job_aid/constants/colors.dart';
import 'package:job_aid/constants/components.dart';
import 'package:job_aid/main.dart';

class AddWorkExperience extends StatefulWidget {
  AddWorkExperience({super.key});

  @override
  State<AddWorkExperience> createState() => _AddWorkExperienceState();
}

class _AddWorkExperienceState extends State<AddWorkExperience> {
  final currentlyWorking = false.obs;

  final now = DateTime.now();

  final TextEditingController fromDate = TextEditingController();

  final TextEditingController toDate = TextEditingController();

  Map<String, dynamic> workExperience = {};

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
          'Work Experience',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  onChanged: (value) {
                    workExperience['job_title'] = value;
                  },
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                    color: AppColor.blackColor,
                    fontSize: 14,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColor.placeholder.withOpacity(0.15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.all(12.5),
                    hintText: 'Job Title',
                    hintStyle: TextStyle(
                      color: AppColor.placeholder,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  onChanged: (value) {
                    workExperience['compnay_name'] = value;
                  },
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                    color: AppColor.blackColor,
                    fontSize: 14,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColor.placeholder.withOpacity(0.15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.all(12.5),
                    hintText: 'Company Name',
                    hintStyle: TextStyle(
                      color: AppColor.placeholder,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: TextFormField(
                        onChanged: (value) {
                          workExperience['date_from'] = value;
                        },
                        controller: fromDate,
                        onTap: () {
                          showPickerDateFrom(context);
                        },
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                          color: AppColor.blackColor,
                          fontSize: 14,
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColor.placeholder.withOpacity(0.15),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.all(12.5),
                          hintText: 'From',
                          hintStyle: TextStyle(
                            color: AppColor.placeholder,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Flexible(
                      flex: 1,
                      child: Obx(() {
                        return TextFormField(
                          onChanged: (value) {
                            workExperience['date_to'] = value;
                          },
                          controller: toDate,
                          enabled: !currentlyWorking.value,
                          onTap: () {
                            showPickerDateTo(context);
                          },
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          style: TextStyle(
                            color: AppColor.blackColor,
                            fontSize: 14,
                          ),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColor.placeholder.withOpacity(0.15),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.all(12.5),
                            hintText: 'To',
                            hintStyle: TextStyle(
                              color: AppColor.placeholder,
                              fontSize: 14,
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Obx(() {
                  return SwitchListTile(
                    value: currentlyWorking.value,
                    onChanged: (value) {
                      currentlyWorking.value = value;
                      workExperience['currently_working'] = value;
                    },
                    title: Text('I am currently working here'),
                    controlAffinity: ListTileControlAffinity.trailing,
                  );
                }),
                const SizedBox(height: 20),
                TextFormField(
                  onChanged: (value) {
                    workExperience['job_description'] = value;
                  },
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                    color: AppColor.blackColor,
                    fontSize: 14,
                  ),
                  maxLines: 7,
                  minLines: 6,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColor.placeholder.withOpacity(0.15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.all(12.5),
                    hintText: 'Job Description',
                    hintStyle: TextStyle(
                      color: AppColor.placeholder,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField(
                  onChanged: (value) {
                    workExperience['employment_type'] = value;
                  },
                  items: [
                    DropdownMenuItem(
                      child: Text('Full-Time'),
                      value: 'Full-Time',
                    ),
                    DropdownMenuItem(
                      child: Text('Part-Time'),
                      value: 'Part-Time',
                    ),
                    DropdownMenuItem(
                      child: Text('Seasonal'),
                      value: 'Seasonal',
                    ),
                    DropdownMenuItem(
                      child: Text('Temporary'),
                      value: 'Temporary',
                    ),
                  ],
                  isDense: true,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColor.blackColor,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColor.placeholder.withOpacity(0.15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.all(12.5),
                    hintText: 'Employment Type',
                    isDense: true,
                    hintStyle: TextStyle(
                      color: AppColor.placeholder,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  onChanged: (value) {
                    workExperience['location'] = value;
                  },
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                    color: AppColor.blackColor,
                    fontSize: 14,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColor.placeholder.withOpacity(0.15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.all(12.5),
                    hintText: 'Location',
                    hintStyle: TextStyle(
                      color: AppColor.placeholder,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField(
                  onChanged: (value) {
                    workExperience['job_level'] = value;
                  },
                  items: [
                    DropdownMenuItem(
                      child: Text('Entry-level'),
                      value: 'Entry-Level',
                    ),
                    DropdownMenuItem(
                      child: Text('Intermediate'),
                      value: 'Intermediate',
                    ),
                    DropdownMenuItem(
                      child: Text('Mid-level'),
                      value: 'Mid-Level',
                    ),
                    DropdownMenuItem(
                      child: Text('Senior or executive-level'),
                      value: 'Senior or Executive-Level',
                    ),
                  ],
                  isDense: true,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColor.blackColor,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColor.placeholder.withOpacity(0.15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.all(12.5),
                    hintText: 'Job Level',
                    isDense: true,
                    hintStyle: TextStyle(
                      color: AppColor.placeholder,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  onChanged: (value) {
                    workExperience['job_function'] = value;
                  },
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                    color: AppColor.blackColor,
                    fontSize: 14,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColor.placeholder.withOpacity(0.15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.all(12.5),
                    hintText: 'Job Function',
                    hintStyle: TextStyle(
                      color: AppColor.placeholder,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  onChanged: (value) {
                    workExperience['salary'] = value;
                  },
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    color: AppColor.blackColor,
                    fontSize: 14,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColor.placeholder.withOpacity(0.15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.all(12.5),
                    hintText: 'Salary',
                    hintStyle: TextStyle(
                      color: AppColor.placeholder,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: DropdownButtonFormField(
                        onChanged: (value) {
                          workExperience['currency'] = value;
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
                          fillColor: AppColor.placeholder.withOpacity(0.15),
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
                    ),
                    SizedBox(width: 10),
                    Flexible(
                      flex: 1,
                      child: DropdownButtonFormField(
                        onChanged: (value) {
                          workExperience['frequency'] = value;
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
                          fillColor: AppColor.placeholder.withOpacity(0.15),
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
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
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
            List workExperiences = jsonDecode(
                    prefs!.getString('userDetails')!)['work_experience'] ??
                [];
            workExperiences.add(workExperience);

            await FirebaseFirestore.instance
                .collection('user_record')
                .doc(user.uid)
                .update({'work_experience': workExperiences}).whenComplete(
                    () async {
              Map<String, dynamic> updateUserData =
                  jsonDecode(prefs!.getString('userDetails')!);
              updateUserData['work_experience'] = workExperiences;
              prefs!.setString('userDetails', jsonEncode(updateUserData));
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              Components.showSnackBar(context, 'Record Updated Successfully');
            }).catchError((e) {
              Navigator.of(context).pop();
              Components.showSnackBar(context, e.toString());
            });
          },
          child: const Text("Add Work Experience"),
        ),
      ),
    );
  }

  showPickerDateFrom(BuildContext context) {
    Picker(
        hideHeader: true,
        adapter: DateTimePickerAdapter(
          customColumnType: [1, 0],
        ),
        title: Text("From"),
        selectedTextStyle: TextStyle(color: AppColor.primaryColor),
        onConfirm: (Picker picker, List value) {
          fromDate.text = DateFormat.yMMM()
              .format((picker.adapter as DateTimePickerAdapter).value!);

          workExperience['date_from'] = DateFormat.yMMM()
              .format((picker.adapter as DateTimePickerAdapter).value!);
        }).showDialog(context);
  }

  showPickerDateTo(BuildContext context) {
    Picker(
        hideHeader: true,
        adapter: DateTimePickerAdapter(
          customColumnType: [1, 0],
        ),
        title: Text("To"),
        selectedTextStyle: TextStyle(color: AppColor.primaryColor),
        onConfirm: (Picker picker, List value) {
          toDate.text = DateFormat.yMMM()
              .format((picker.adapter as DateTimePickerAdapter).value!);
          workExperience['date_to'] = DateFormat.yMMM()
              .format((picker.adapter as DateTimePickerAdapter).value!);
        }).showDialog(context);
  }
}
