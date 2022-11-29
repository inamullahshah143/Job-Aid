import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_aid/constants/colors.dart';
import 'package:job_aid/constants/components.dart';
import 'package:job_aid/main.dart';

class AddLanguage extends StatefulWidget {
  const AddLanguage({super.key});

  @override
  State<AddLanguage> createState() => _AddLanguageState();
}

class _AddLanguageState extends State<AddLanguage> {
  Map<String, dynamic> language = {};
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
          'Language',
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
                    language['language'] = value;
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
                    hintText: 'Language',
                    hintStyle: TextStyle(
                      color: AppColor.placeholder,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField(
                  onChanged: (value) {
                    language['proficiency'] = value;
                  },
                  items: [
                    DropdownMenuItem(
                      child: Text('Native or Bilingual Proficiency'),
                      value: 'Native or Bilingual Proficiency',
                    ),
                    DropdownMenuItem(
                      child: Text('Elementary Proficiency'),
                      value: 'Elementary Proficiency',
                    ),
                    DropdownMenuItem(
                      child: Text('Limited Working Proficiency'),
                      value: 'Limited Working Proficiency',
                    ),
                    DropdownMenuItem(
                      child: Text('Professional Working Proficiency'),
                      value: 'Professional Working Proficiency',
                    ),
                    DropdownMenuItem(
                      child: Text('Full Professional Proficiency'),
                      value: 'Full Professional Proficiency',
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
                    hintText: 'Proficiency',
                    isDense: true,
                    hintStyle: TextStyle(
                      color: AppColor.placeholder,
                      fontSize: 14,
                    ),
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
            List languages =
                jsonDecode(prefs!.getString('userDetails')!)['languages'] ?? [];
            languages.add(language);
            await FirebaseFirestore.instance
                .collection('user_record')
                .doc(user.uid)
                .update({'languages': languages}).whenComplete(() async {
              Map<String, dynamic> updateUserData =
                  jsonDecode(prefs!.getString('userDetails')!);
              updateUserData['languages'] = languages;
              prefs!.setString('userDetails', jsonEncode(updateUserData));
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              Components.showSnackBar(context, 'Record Updated Successfully');
            }).catchError((e) {
              Navigator.of(context).pop();
              Components.showSnackBar(context, e.toString());
            });
          },
          child: const Text("Add Language"),
        ),
      ),
    );
  }
}
