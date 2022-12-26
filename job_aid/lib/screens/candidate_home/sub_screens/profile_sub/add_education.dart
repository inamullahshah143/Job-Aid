import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:job_aid/constants/colors.dart';
import 'package:job_aid/constants/components.dart';
import 'package:job_aid/main.dart';
import 'package:job_aid/utils/upload_file.dart';

class AddEducation extends StatefulWidget {
  final bool isUpdate;
  final Map<String, dynamic> data;
  AddEducation({super.key, required this.isUpdate, required this.data});

  @override
  State<AddEducation> createState() => _AddEducationState();
}

class _AddEducationState extends State<AddEducation> {
  final currentlyLearning = false.obs;
  final now = DateTime.now();
  TextEditingController fromDate = TextEditingController();
  TextEditingController toDate = TextEditingController();

  Map<String, dynamic> education = {};

  File? attachments;
  bool? isUpdate;
  @override
  void initState() {
    education = widget.data;
    fromDate = TextEditingController(text: education['from']);
    toDate = TextEditingController(text: education['to']);
    currentlyLearning.value = education['graduated'] ?? false;
    isUpdate = widget.isUpdate;
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
          'Education',
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
                DropdownButtonFormField(
                  value: education['educational_attainment'],
                  onChanged: (value) {
                    education['educational_attainment'] = value;
                  },
                  items: [
                    DropdownMenuItem(
                      child: Text('Primary'),
                      value: 'Primary',
                    ),
                    DropdownMenuItem(
                      child: Text('Lower Secondary'),
                      value: 'Lower Secondary',
                    ),
                    DropdownMenuItem(
                      child: Text('Upper Secondary'),
                      value: 'Upper Secondary',
                    ),
                    DropdownMenuItem(
                      child: Text('Post-secondary'),
                      value: 'Post-secondary',
                    ),
                    DropdownMenuItem(
                      child: Text('Short-cycle'),
                      value: 'Short-cycle',
                    ),
                    DropdownMenuItem(
                      child: Text('Bachelors degree'),
                      value: 'Bachelors degree',
                    ),
                    DropdownMenuItem(
                      child: Text('Masters degree'),
                      value: 'Masters degree',
                    ),
                    DropdownMenuItem(
                      child: Text('Doctoral degree'),
                      value: 'Doctoral degree',
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
                    hintText: 'Educational Attainment',
                    isDense: true,
                    hintStyle: TextStyle(
                      color: AppColor.placeholder,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: TextEditingController(text: education['course']),
                  onChanged: (value) {
                    education['course'] = value;
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
                    hintText: 'Course',
                    hintStyle: TextStyle(
                      color: AppColor.placeholder,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller:
                      TextEditingController(text: education['institute']),
                  onChanged: (value) {
                    education['institute'] = value;
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
                    hintText: 'Institute',
                    hintStyle: TextStyle(
                      color: AppColor.placeholder,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Obx(() {
                  return SwitchListTile(
                    value: currentlyLearning.value,
                    onChanged: (value) {
                      currentlyLearning.value = value;
                      education['graduated'] = value;
                    },
                    title: Text('Graduated'),
                    controlAffinity: ListTileControlAffinity.trailing,
                  );
                }),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: TextFormField(
                        onChanged: (value) {
                          education['from'] = value;
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
                            education['to'] = value;
                          },
                          controller: toDate,
                          enabled: currentlyLearning.value,
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
                const SizedBox(height: 20),
                Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: TextFormField(
                        controller:
                            TextEditingController(text: education['score']),
                        onChanged: (value) {
                          education['score'] = value;
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
                          hintText: 'Score',
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
                      child: TextFormField(
                        controller:
                            TextEditingController(text: education['scale']),
                        onChanged: (value) {
                          education['scale'] = value;
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
                          hintText: 'Scale',
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
                TextFormField(
                  controller:
                      TextEditingController(text: education['description']),
                  onChanged: (value) {
                    education['description'] = value;
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
                FormField(
                  initialValue: false,
                  validator: (value) {
                    if (attachments == null) {
                      return 'please upload attachments';
                    }
                    return null;
                  },
                  builder: (field) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                            children: [
                              WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: ElevatedButton(
                                  onPressed: () {
                                    pickAttachments();
                                  },
                                  child: Text('Upload Attchments'),
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            AppColor.transparent),
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            AppColor.primaryColor),
                                    overlayColor:
                                        MaterialStateProperty.all<Color>(
                                            AppColor.primary.withOpacity(0.1)),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          side: BorderSide(
                                              color: AppColor.primaryColor)),
                                    ),
                                  ),
                                ),
                              ),
                              TextSpan(text: '   '),
                              TextSpan(
                                text: attachments != null
                                    ? attachments!.path.split('/').last
                                    : '',
                                style: TextStyle(
                                  color: AppColor.blackColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          field.errorText ?? '',
                          style: TextStyle(
                            color: Theme.of(context).errorColor,
                            fontSize: 12,
                          ),
                        )
                      ],
                    );
                  },
                ),
                const SizedBox(height: 5),
                const Text(
                  '*Please must attached your educational documents for better experience.',
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
          onPressed: isUpdate!
              ? () async {
                  Components.showAlertDialog(context);
                  if (attachments != null) {
                    await UploadFiles()
                        .uploadFile('Education', education['attachment'])
                        .then((value) {
                      education['attachment'] = value;
                    }).whenComplete(() async {
                      List educations = jsonDecode(
                              prefs!.getString('userDetails')!)['educations'] ??
                          [];

                      educations.removeAt(education['index']);
                      educations.add(education);
                      await FirebaseFirestore.instance
                          .collection('user_record')
                          .doc(user.uid)
                          .update({'educations': educations}).whenComplete(
                              () async {
                        Map<String, dynamic> updateUserData =
                            jsonDecode(prefs!.getString('userDetails')!);
                        updateUserData['educations'] = educations;
                        prefs!.setString(
                            'userDetails', jsonEncode(updateUserData));
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                        Components.showSnackBar(
                            context, 'Record Updated Successfully');
                      }).catchError((e) {
                        Navigator.of(context).pop();
                        Components.showSnackBar(context, e.toString());
                      });
                    }).catchError((e) {
                      Navigator.of(context).pop();
                      Components.showSnackBar(context, e.toString());
                    });
                  } else {
                    List educations = jsonDecode(
                            prefs!.getString('userDetails')!)['educations'] ??
                        [];
                    educations.removeAt(education['index']);
                    educations.add(education);
                    await FirebaseFirestore.instance
                        .collection('user_record')
                        .doc(user.uid)
                        .update({'educations': educations}).whenComplete(
                            () async {
                      Map<String, dynamic> updateUserData =
                          jsonDecode(prefs!.getString('userDetails')!);
                      updateUserData['educations'] = educations;
                      prefs!
                          .setString('userDetails', jsonEncode(updateUserData));
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      Components.showSnackBar(
                          context, 'Record Updated Successfully');
                    }).catchError((e) {
                      Navigator.of(context).pop();
                      Components.showSnackBar(context, e.toString());
                    });
                  }
                }
              : () async {
                  Components.showAlertDialog(context);
                  await UploadFiles()
                      .uploadFile('Education', education['attachment'])
                      .then((value) {
                    education['attachment'] = value;
                  }).whenComplete(() async {
                    List educations = jsonDecode(
                            prefs!.getString('userDetails')!)['educations'] ??
                        [];
                    educations.add(education);
                    await FirebaseFirestore.instance
                        .collection('user_record')
                        .doc(user.uid)
                        .update({'educations': educations}).whenComplete(
                            () async {
                      Map<String, dynamic> updateUserData =
                          jsonDecode(prefs!.getString('userDetails')!);
                      updateUserData['educations'] = educations;
                      prefs!
                          .setString('userDetails', jsonEncode(updateUserData));
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      Components.showSnackBar(
                          context, 'Record Updated Successfully');
                    }).catchError((e) {
                      Navigator.of(context).pop();
                      Components.showSnackBar(context, e.toString());
                    });
                  }).catchError((e) {
                    Navigator.of(context).pop();
                    Components.showSnackBar(context, e.toString());
                  });
                },
          child: Text(isUpdate! ? "Update Education" : "Add Education"),
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

          education['from'] = DateFormat.yMMM()
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

          education['to'] = DateFormat.yMMM()
              .format((picker.adapter as DateTimePickerAdapter).value!);
        }).showDialog(context);
  }

  pickAttachments() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc'],
    );
    if (result != null) {
      setState(() {
        attachments = File(result.files.single.path!);
        education['attachment'] = attachments;
      });
    }
  }
}
