import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:job_aid/constants/colors.dart';
import 'package:job_aid/constants/components.dart';
import 'package:job_aid/constants/industries_list.dart';
import 'package:job_aid/constants/k_images.dart';
import 'package:job_aid/constants/models/step_model.dart';
import 'package:job_aid/constants/multi_step_form.dart';
import 'package:job_aid/main.dart';
import 'package:job_aid/screens/candidate_home/candidate_dashboard.dart';
import 'package:job_aid/utils/auth_helper.dart';
import 'package:job_aid/utils/upload_file.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CandidateRegistration extends StatefulWidget {
  CandidateRegistration({super.key});

  @override
  State<CandidateRegistration> createState() => _CandidateRegistrationState();
}

class _CandidateRegistrationState extends State<CandidateRegistration> {
  final isChecked = false.obs;
  final isVisible = false.obs;
  final industries = <DropdownMenuItem>[];
  String? city;
  String? province;
  String? country;
  final gender = ''.obs;
  File? profilePicture;
  File? cvFile;
  final String initialCountry = 'PK';
  final PhoneNumber number = PhoneNumber(isoCode: 'PK', dialCode: '+92');
  final isValidNo = true.obs;
  Map<String, dynamic> formData = {};
  @override
  void initState() {
    readIndustries();
    super.initState();
  }

  void readIndustries() {
    for (var item in IndustriesList.industries) {
      industries.add(
        DropdownMenuItem(
          child: Text(
            item,
          ),
          value: item,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
          'Already Have an account?',
          style: Theme.of(context).textTheme.subtitle1!.copyWith(
                color: AppColor.blackColor,
              ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          const Text(
            'Candidate Registration Form',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColor.blackColor,
            ),
          ),
          Expanded(
            child: MultiStepForm(
              buttonBackgroundColor: AppColor.primaryColor,
              onCompleted: () {
                Components.showAlertDialog(context);
                AuthenticationHelper()
                    .signUp(
                        email: formData['email'],
                        password: formData['password'])
                    .then((value) {
                  if (value != null) {
                    UploadFiles()
                        .uploadFile(
                            'Profile Picture', formData['profile_picture'])
                        .then((profileUrl) async {
                      formData['profile_picture'] = profileUrl;
                      UploadFiles()
                          .uploadFile('CV\\Resume', formData['cv'])
                          .then((cvUrl) async {
                        formData['cv'] = cvUrl;
                        print(formData);
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(value.user.uid)
                            .set({
                          'email': formData['email'],
                          'phone_no': formData['phone_no'],
                          'name': formData['name']
                        }).then((userData) async {
                          await FirebaseFirestore.instance
                              .collection('user_record')
                              .doc(value.user.uid)
                              .set({
                            'about': formData['about'],
                            'profile_picture': formData['profile_picture'],
                            'cv': formData['cv'],
                            'cv_size': formData['cv_size'],
                            'cnic_no': formData['cnic_no'],
                            'gender': formData['gender'],
                            'experties': formData['experties'],
                            'complete_address': formData['complete_address'],
                            'city': formData['city'],
                            'province': formData['province'],
                            'country': formData['country'],
                            'terms&conditions': formData['terms&conditions'],
                            'industry': formData['industry'],
                          }).then((record) {
                            prefs!
                                .setString('userDetails', jsonEncode(formData));
                            Navigator.of(context).pop();
                            Get.offAll(CandidateDashboard());
                            Components.showSnackBar(
                                context, 'Welcome to Job Aid');
                          }).catchError((e) {
                            Navigator.of(context).pop();
                            Components.showSnackBar(context, e.toString());
                          });
                        }).catchError((e) {
                          Navigator.of(context).pop();
                          Components.showSnackBar(context, e.toString());
                        });
                      }).catchError((e) {
                        Navigator.of(context).pop();
                        Components.showSnackBar(context, e.toString());
                      });
                    }).catchError((e) {
                      Navigator.of(context).pop();
                      Components.showSnackBar(context, e.toString());
                    });
                  }
                }).catchError((e) {
                  Navigator.of(context).pop();
                  Components.showSnackBar(context, e.toString());
                });
              },
              selectedColor: AppColor.primaryColor,
              unselectedColor: AppColor.primary.withOpacity(0.5),
              steps: [
                StepModel(
                  title: 'User',
                  body: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          TextFormField(
                            onChanged: (value) {
                              formData['email'] = value;
                            },
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              hintText: 'Your Email',
                              labelText: 'Your Email',
                            ),
                          ),
                          const SizedBox(height: 20),
                          Obx(() {
                            return TextFormField(
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: isVisible.value,
                              decoration: InputDecoration(
                                hintText: 'Password',
                                labelText: 'Password',
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    isVisible.value = !isVisible.value;
                                  },
                                  icon: Icon(
                                    isVisible.isTrue
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                ),
                              ),
                            );
                          }),
                          const SizedBox(height: 16),
                          Obx(() {
                            return TextFormField(
                              onChanged: (value) {
                                formData['password'] = value;
                              },
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: isVisible.value,
                              decoration: InputDecoration(
                                hintText: 'Confirm Password',
                                labelText: 'Confirm Password',
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    isVisible.value = !isVisible.value;
                                  },
                                  icon: Icon(
                                    isVisible.isTrue
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                ),
                              ),
                            );
                          }),
                          const SizedBox(height: 16),
                          FormField(
                            initialValue: isChecked.value,
                            validator: (value) {
                              if (value == false) {
                                return 'please make sure that you are agree with terms and conditions';
                              }
                              return null;
                            },
                            builder: (field) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Obx(() {
                                    return CheckboxListTile(
                                      contentPadding: EdgeInsets.zero,
                                      controlAffinity:
                                          ListTileControlAffinity.leading,
                                      dense: true,
                                      value: isChecked.value,
                                      onChanged: (value) {
                                        field.didChange(value);
                                        isChecked.value = value!;
                                        formData['terms&conditions'] = value;
                                      },
                                      title: RichText(
                                        softWrap: true,
                                        textAlign: TextAlign.start,
                                        text: TextSpan(
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: AppColor.blackColor,
                                          ),
                                          children: [
                                            const TextSpan(
                                                text:
                                                    'By creating account I\'m agree with job finding '),
                                            TextSpan(
                                              text: ' terms & condition',
                                              style: const TextStyle(
                                                color: Colors.red,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            const TextSpan(text: ' and '),
                                            TextSpan(
                                              text: 'privacy policy',
                                              style: const TextStyle(
                                                color: Colors.red,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
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
                        ],
                      ),
                    ),
                  ),
                ),
                StepModel(
                  title: 'Profession',
                  body: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          TextFormField(
                            onChanged: (value) {
                              formData['experties'] = value;
                            },
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              hintText: 'Experties',
                              labelText: 'Experties',
                              helperText: 'Example: Senior UI/UX designer',
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            'Your profile headline is an opportunity to share in a few words your occupation, interests, or other information which you want to highlight about yourself.',
                            style: TextStyle(
                              color: AppColor.labelColor,
                              fontSize: 12.0,
                            ),
                          ),
                          const SizedBox(height: 20),
                          DropdownButtonFormField(
                            onChanged: (value) {
                              formData['industry'] = value;
                            },
                            items: industries,
                            isDense: true,
                            iconSize: 0.0,
                            decoration: const InputDecoration(
                              hintText: 'Industry',
                              labelText: 'Industry',
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            'Adding your industry helps to share more information about yourself and find more connections on RemoteHub, as well as to get recommendations about the jobs relevant for this industry.',
                            style: TextStyle(
                              color: AppColor.labelColor,
                              fontSize: 12.0,
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            onChanged: (value) {
                              formData['about'] = value;
                            },
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            maxLines: 6,
                            minLines: 5,
                            textAlignVertical: TextAlignVertical.top,
                            decoration: const InputDecoration(
                                hintText: 'About',
                                labelText: 'About',
                                alignLabelWithHint: true,
                                helperText:
                                    'Example: I\'m a Digital Marketing Specialist with 5 years of experience'),
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            'Provide details about yourself, your work interest, and your strong sides.',
                            style: TextStyle(
                              color: AppColor.labelColor,
                              fontSize: 12.0,
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                ),
                StepModel(
                  title: 'Address',
                  body: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          CSCPicker(
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
                            onCountryChanged: (value) {
                              setState(() {
                                formData['country'] = value;
                                country = value;
                              });
                            },
                            onStateChanged: (value) {
                              setState(() {
                                formData['province'] = value;
                                province = value;
                              });
                            },
                            onCityChanged: (value) {
                              setState(() {
                                formData['city'] = value;
                                city = value;
                              });
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            onChanged: (value) {
                              formData['complete_address'] = value;
                            },
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            minLines: 5,
                            maxLines: 6,
                            decoration: const InputDecoration(
                              hintText: 'Postal Address',
                              labelText: 'Postal Address',
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            'Adding your country, city and state or province helps to share more information about yourself and find more connections on RemoteHub. It will also help to get recommendations about local jobs available in your city, and match you with potential employers.',
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
                StepModel(
                  title: 'Profile & CV',
                  body: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FormField(
                            initialValue: false,
                            validator: (value) {
                              if (profilePicture == null) {
                                return 'please add your profile picture';
                              }
                              return null;
                            },
                            builder: (field) {
                              return Column(
                                children: [
                                  Center(
                                    child: Column(
                                      children: [
                                        CircleAvatar(
                                          radius: 50,
                                          backgroundColor: AppColor.transparent,
                                          backgroundImage:
                                              profilePicture != null
                                                  ? Image.file(
                                                      profilePicture!,
                                                      fit: BoxFit.fill,
                                                    ).image
                                                  : Image.asset(
                                                      Kimages.profileIcon,
                                                      fit: BoxFit.fill,
                                                    ).image,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        MaterialButton(
                                          onPressed: () {
                                            showModalBottomSheet(
                                                context: context,
                                                builder: (context) {
                                                  return SizedBox(
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10.0),
                                                          child: IconButton(
                                                            onPressed: () {
                                                              getFromCamera();
                                                            },
                                                            icon: const Icon(
                                                                FontAwesome5
                                                                    .camera),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10.0),
                                                          child: IconButton(
                                                            onPressed: () {
                                                              getFromGallery();
                                                            },
                                                            icon: const Icon(
                                                                FontAwesome5
                                                                    .images),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                });
                                          },
                                          child: RichText(
                                            text: TextSpan(
                                              children: [
                                                WidgetSpan(
                                                  child: Icon(
                                                    FontAwesome5.upload,
                                                    color: AppColor.blackColor,
                                                    size: 16,
                                                  ),
                                                  alignment:
                                                      PlaceholderAlignment
                                                          .middle,
                                                ),
                                                TextSpan(
                                                  text: " Upload Profile Image",
                                                  style: TextStyle(
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
                          const SizedBox(height: 20),
                          TextFormField(
                            onChanged: (value) {
                              formData['name'] = value;
                            },
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              hintText: 'Your Name',
                              labelText: 'Your Name',
                            ),
                          ),
                          const SizedBox(height: 20),
                          InternationalPhoneNumberInput(
                            onInputChanged: (PhoneNumber number) {
                              formData['phone_no'] = number.phoneNumber;
                            },
                            onInputValidated: (bool value) {
                              isValidNo.value = value;
                            },
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
                            keyboardType: const TextInputType.numberWithOptions(
                                signed: true, decimal: true),
                            inputDecoration: const InputDecoration(
                              hintText: 'Your Phone No.',
                              labelText: 'Your Phone No.',
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            onChanged: (value) {
                              formData['cnic_no'] = value;
                            },
                            inputFormatters: [
                              MaskTextInputFormatter(
                                mask: "#####-#######-#",
                              )
                            ],
                            keyboardType: TextInputType.number,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'please enter the cnic';
                              } else if (value.length < 15) {
                                return 'please enter a valid cnic';
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              labelText: 'Your CNIC No.',
                              hintText: 'Your CNIC No.',
                            ),
                          ),
                          const SizedBox(height: 20),
                          DropdownButtonFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'please select the gender';
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              labelText: 'Gender',
                              hintText: 'Gender',
                            ),
                            items: const [
                              DropdownMenuItem(
                                value: 'male',
                                child: Text('Male'),
                              ),
                              DropdownMenuItem(
                                value: 'female',
                                child: Text('Female'),
                              ),
                              DropdownMenuItem(
                                value: 'other',
                                child: Text('Other'),
                              ),
                            ],
                            onChanged: (String? value) {
                              gender.value = value!;
                              formData['gender'] = value;
                            },
                          ),
                          const SizedBox(height: 20),
                          FormField(
                            initialValue: false,
                            validator: (value) {
                              if (cvFile == null) {
                                return 'please upload your CV\\Resume';
                              }
                              return null;
                            },
                            builder: (field) {
                              return Column(
                                children: [
                                  RichText(
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    text: TextSpan(
                                      children: [
                                        WidgetSpan(
                                          alignment:
                                              PlaceholderAlignment.middle,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              pickCV();
                                            },
                                            child: Text('Choose File'),
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                          Color>(
                                                      AppColor.primaryColor),
                                              foregroundColor:
                                                  MaterialStateProperty.all<
                                                      Color>(AppColor.white),
                                              overlayColor:
                                                  MaterialStateProperty.all<
                                                          Color>(
                                                      AppColor.primary
                                                          .withOpacity(0.1)),
                                              shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        TextSpan(text: '   '),
                                        TextSpan(
                                          text: cvFile != null
                                              ? cvFile!.path.split('/').last
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
                            '*Please must attached your CV for better experience.',
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
              ],
            ),
          ),
        ],
      ),
    );
  }

  getFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        profilePicture = File(pickedFile.path);
        formData['profile_picture'] = profilePicture;
      });
    }
  }

  getFromCamera() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      setState(() {
        profilePicture = File(pickedFile.path);
        formData['profile_picture'] = profilePicture;
      });
    }
  }

  pickCV() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc'],
    );
    if (result != null) {
      setState(() {
        cvFile = File(result.files.single.path!);
        formData['cv'] = cvFile;
        formData['cv_size'] = formatSizeUnits(cvFile!.lengthSync());
      });
    }
  }

  formatSizeUnits(bytes) {
    if (bytes >= 1073741824) {
      bytes = (bytes / 1073741824).toStringAsFixed(2) + " GB";
    } else if (bytes >= 1048576) {
      bytes = (bytes / 1048576).toStringAsFixed(2) + " MB";
    } else if (bytes >= 1024) {
      bytes = (bytes / 1024).toStringAsFixed(2) + " KB";
    } else if (bytes > 1) {
      bytes = bytes + " bytes";
    } else if (bytes == 1) {
      bytes = bytes + " byte";
    } else {
      bytes = "0 bytes";
    }
    return bytes;
  }
}
