import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:job_aid/constants/components.dart';
import 'package:job_aid/main.dart';
import 'package:job_aid/utils/upload_file.dart';

import '../../../../constants/colors.dart';

class AddCertificate extends StatefulWidget {
  final bool isUpdate;
  final Map<String, dynamic> data;
  AddCertificate({super.key, required this.isUpdate, required this.data});

  @override
  State<AddCertificate> createState() => _AddCertificateState();
}

class _AddCertificateState extends State<AddCertificate> {
  final willExpire = false.obs;

  final now = DateTime.now();

  TextEditingController issueDate = TextEditingController();

  TextEditingController expireDate = TextEditingController();

  File? attachments;

  bool? isUpdate;

  Map<String, dynamic> certificate = {};
  @override
  void initState() {
    certificate = widget.data;
    issueDate = TextEditingController(text: certificate['date_of_issue']);
    expireDate = TextEditingController(text: certificate['date_of_expire']);
    willExpire.value = certificate['will_expire'] ?? false;
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
          'Certificates',
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
                  controller: TextEditingController(text: certificate['title']),
                  onChanged: (value) {
                    certificate['title'] = value;
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
                    hintText: 'Title',
                    hintStyle: TextStyle(
                      color: AppColor.placeholder,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: TextEditingController(
                      text: certificate['publishing_organization']),
                  onChanged: (value) {
                    certificate['publishing_organization'] = value;
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
                    hintText: 'Publishing Organization',
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
                          certificate['date_of_issue'] = value;
                        },
                        controller: issueDate,
                        onTap: () {
                          showPickerDateIssue(context);
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
                          hintText: 'Date of Issue',
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
                            certificate['date_of_expire'] = value;
                          },
                          controller: expireDate,
                          enabled: willExpire.value,
                          onTap: () {
                            showPickerDateExpire(context);
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
                            hintText: 'Expiration Date',
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
                  return CheckboxListTile(
                    value: willExpire.value,
                    onChanged: (value) {
                      willExpire.value = value!;
                      certificate['will_expire'] = value;
                    },
                    title: Text('This cridential will not expire'),
                    controlAffinity: ListTileControlAffinity.leading,
                  );
                }),
                const SizedBox(height: 20),
                TextFormField(
                  controller:
                      TextEditingController(text: certificate['cridential_id']),
                  onChanged: (value) {
                    certificate['cridential_id'] = value;
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
                    hintText: 'Cridential ID',
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
                      return 'please upload certificate';
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
                                  child: Text('Upload Certificate'),
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
                  '*Please must attached your certificate documents.',
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
                        .uploadFile('Certificate', certificate['attachments'])
                        .then((value) {
                      certificate['attachments'] = value;
                    }).whenComplete(() async {
                      List certificates =
                          jsonDecode(prefs!.getString('userDetails')!)[
                                  'certificate'] ??
                              [];

                      certificates.removeAt(certificate['index']);
                      certificates.add(certificate);
                      await FirebaseFirestore.instance
                          .collection('user_record')
                          .doc(user.uid)
                          .update({'certificate': certificates}).whenComplete(
                              () async {
                        Map<String, dynamic> updateUserData =
                            jsonDecode(prefs!.getString('userDetails')!);
                        updateUserData['certificate'] = certificates;
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
                    List certificates = jsonDecode(
                            prefs!.getString('userDetails')!)['certificate'] ??
                        [];

                    certificates.removeAt(certificate['index']);
                    certificates.add(certificate);
                    await FirebaseFirestore.instance
                        .collection('user_record')
                        .doc(user.uid)
                        .update({'certificate': certificates}).whenComplete(
                            () async {
                      Map<String, dynamic> updateUserData =
                          jsonDecode(prefs!.getString('userDetails')!);
                      updateUserData['certificate'] = certificates;
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
                      .uploadFile('Certificate', certificate['attachments'])
                      .then((value) {
                    certificate['attachments'] = value;
                  }).whenComplete(() async {
                    List certificates = jsonDecode(
                            prefs!.getString('userDetails')!)['certificate'] ??
                        [];
                    certificates.add(certificate);
                    await FirebaseFirestore.instance
                        .collection('user_record')
                        .doc(user.uid)
                        .update({'certificate': certificates}).whenComplete(
                            () async {
                      Map<String, dynamic> updateUserData =
                          jsonDecode(prefs!.getString('userDetails')!);
                      updateUserData['certificate'] = certificates;
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
          child: Text(isUpdate! ? "Update Certificate" : "Add Certificate"),
        ),
      ),
    );
  }

  showPickerDateIssue(BuildContext context) {
    Picker(
        hideHeader: true,
        adapter: DateTimePickerAdapter(
          customColumnType: [1, 0],
        ),
        title: Text("From"),
        selectedTextStyle: TextStyle(color: AppColor.primaryColor),
        onConfirm: (Picker picker, List value) {
          issueDate.text = DateFormat.yMMM()
              .format((picker.adapter as DateTimePickerAdapter).value!);
          certificate['date_of_issue'] = DateFormat.yMMM()
              .format((picker.adapter as DateTimePickerAdapter).value!);
        }).showDialog(context);
  }

  showPickerDateExpire(BuildContext context) {
    Picker(
        hideHeader: true,
        adapter: DateTimePickerAdapter(
          customColumnType: [1, 0],
        ),
        title: Text("To"),
        selectedTextStyle: TextStyle(color: AppColor.primaryColor),
        onConfirm: (Picker picker, List value) {
          expireDate.text = DateFormat.yMMM()
              .format((picker.adapter as DateTimePickerAdapter).value!);
          certificate['date_of_expire'] = DateFormat.yMMM()
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
        certificate['attachments'] = attachments;
      });
    }
  }
}
