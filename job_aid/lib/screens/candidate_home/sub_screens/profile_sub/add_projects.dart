import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:job_aid/constants/colors.dart';
import 'package:job_aid/constants/components.dart';
import 'package:job_aid/main.dart';

class AddProjects extends StatefulWidget {
  final bool isUpdate;
  final Map<String, dynamic> data;
  AddProjects({super.key, required this.isUpdate, required this.data});


  @override
  State<AddProjects> createState() => _AddProjectsState();
}

class _AddProjectsState extends State<AddProjects> {
  final currentlyWorking = false.obs;

  final now = DateTime.now();

  final TextEditingController fromDate = TextEditingController();

  final TextEditingController toDate = TextEditingController();

  Map<String, dynamic> project = {};

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
          'Projects',
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
                    project['project_name'] = value;
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
                    hintText: 'Project Name',
                    hintStyle: TextStyle(
                      color: AppColor.placeholder,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  onChanged: (value) {
                    project['your_role'] = value;
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
                    hintText: 'Your Role',
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
                          project['from'] = value;
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
                            project['to'] = value;
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
                      project['current'] = value;
                    },
                    title: Text('Current'),
                    controlAffinity: ListTileControlAffinity.trailing,
                  );
                }),
                const SizedBox(height: 20),
                TextFormField(
                  onChanged: (value) {
                    project['associated_with'] = value;
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
                    hintText: 'Associated with',
                    hintStyle: TextStyle(
                      color: AppColor.placeholder,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  onChanged: (value) {
                    project['description'] = value;
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
                    hintText: 'Description',
                    hintStyle: TextStyle(
                      color: AppColor.placeholder,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  onChanged: (value) {
                    project['project_url'] = value;
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
                    hintText: 'Project URL',
                    hintStyle: TextStyle(
                      color: AppColor.placeholder,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  '*Please must enter your project url.',
                  style: TextStyle(
                    color: AppColor.labelColor,
                    fontSize: 12.0,
                  ),
                ),
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
            List projects =
                jsonDecode(prefs!.getString('userDetails')!)['projects'] ?? [];
            projects.add(project);
            await FirebaseFirestore.instance
                .collection('user_record')
                .doc(user.uid)
                .update({'projects': projects}).whenComplete(() async {
              Map<String, dynamic> updateUserData =
                  jsonDecode(prefs!.getString('userDetails')!);
              updateUserData['projects'] = projects;
              prefs!.setString('userDetails', jsonEncode(updateUserData));
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              Components.showSnackBar(context, 'Record Updated Successfully');
            }).catchError((e) {
              Navigator.of(context).pop();
              Components.showSnackBar(context, e.toString());
            });
          },
          child: const Text("Add Project"),
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
          project['from'] = DateFormat.yMMM()
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
          project['to'] = DateFormat.yMMM()
              .format((picker.adapter as DateTimePickerAdapter).value!);
        }).showDialog(context);
  }
}
