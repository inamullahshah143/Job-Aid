import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chip_tags/flutter_chip_tags.dart';
import 'package:get/get.dart';
import 'package:job_aid/constants/colors.dart';
import 'package:job_aid/constants/components.dart';
import 'package:job_aid/main.dart';

class AddSkills extends StatefulWidget {
  AddSkills({super.key});

  @override
  State<AddSkills> createState() => _AddSkillsState();
}

class _AddSkillsState extends State<AddSkills> {
  List<String>? _items;
  @override
  void initState() {
    _items = List<String>.from(
        jsonDecode(prefs!.getString('userDetails')!)['skills']??[]);
    super.initState();
  }

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
          'Skills',
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Your Skills',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColor.blackColor,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  '*You can add multiple skills by using "," as separator.',
                  style: TextStyle(
                    color: AppColor.labelColor,
                    fontSize: 12.0,
                  ),
                ),
                const SizedBox(height: 20),
                ChipTags(
                  list: _items!,
                  chipColor: AppColor.primaryColor,
                  iconColor: Colors.white,
                  textColor: Colors.white,
                  separator: ',',
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColor.placeholder.withOpacity(0.15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.all(12.5),
                    hintText: 'Type here..',
                    hintStyle: TextStyle(
                      color: AppColor.placeholder,
                      fontSize: 14,
                    ),
                  ),
                  keyboardType: TextInputType.text,
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
            List skills =
                jsonDecode(prefs!.getString('userDetails')!)['skills'] ?? [];
            skills.addAll(_items!);
            await FirebaseFirestore.instance
                .collection('user_record')
                .doc(user.uid)
                .update({'skills': skills}).whenComplete(() async {
              Map<String, dynamic> updateUserData =
                  jsonDecode(prefs!.getString('userDetails')!);
              updateUserData['skills'] = skills;
              prefs!.setString('userDetails', jsonEncode(updateUserData));
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              Components.showSnackBar(context, 'Record Updated Successfully');
            }).catchError((e) {
              Navigator.of(context).pop();
              Components.showSnackBar(context, e.toString());
            });
          },
          child: const Text("Add Skill"),
        ),
      ),
    );
  }
}
