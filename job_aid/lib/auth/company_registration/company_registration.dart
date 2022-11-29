import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:job_aid/constants/colors.dart';
import 'package:job_aid/constants/components.dart';
import 'package:job_aid/constants/k_images.dart';
import 'package:job_aid/constants/models/step_model.dart';
import 'package:job_aid/constants/multi_step_form.dart';
import 'package:job_aid/main.dart';
import 'package:job_aid/screens/company_home/company_dashboard.dart';
import 'package:job_aid/utils/auth_helper.dart';
import 'package:job_aid/utils/helper.dart';
import 'package:job_aid/utils/upload_file.dart';

class CompanyRegistration extends StatefulWidget {
  const CompanyRegistration({super.key});

  @override
  State<CompanyRegistration> createState() => _CompanyRegistrationState();
}

class _CompanyRegistrationState extends State<CompanyRegistration> {
  final isChecked = false.obs;
  final isVisible = false.obs;
  final industries = <DropdownMenuItem>[].obs;
  final cities = <DropdownMenuItem>[].obs;
  final provinces = <DropdownMenuItem>[].obs;
  final province = 'Punjab'.obs;
  File? company_logo;
  final String initialCountry = 'PK';
  final PhoneNumber number = PhoneNumber(isoCode: 'PK', dialCode: '+92');
  final isValidNo = true.obs;
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController conf_password = TextEditingController();
  final TextEditingController company_name = TextEditingController();
  final TextEditingController country = TextEditingController(text: 'Pakistan');
  final TextEditingController company_address = TextEditingController();
  Map<String, dynamic> formData = {};
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      readIndustries();
      readCities();
      readProvince();
    });
    super.initState();
  }

  Future readIndustries() async {
    final String response =
        await rootBundle.loadString('assets/json/industries.json');
    final data = await json.decode(response);
    for (var item in data['data']) {
      industries.add(
        DropdownMenuItem(
          child: Text(
            item['title'],
          ),
          value: item['title'],
        ),
      );
    }
  }

  Future readProvince() async {
    final String response =
        await rootBundle.loadString('assets/json/province.json');
    final data = await json.decode(response);
    provinces.clear();
    for (var item in data['data']) {
      provinces.add(
        DropdownMenuItem(
          child: Text(
            item['title'],
          ),
          value: item['title'],
        ),
      );
    }
  }

  Future readCities() async {
    final String response =
        await rootBundle.loadString('assets/json/cities.json');
    final data = await json.decode(response);
    cities.clear();
    for (var item in data['data'][province.value]) {
      cities.add(
        DropdownMenuItem(
          child: Text(
            item['title'],
          ),
          value: item['title'],
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
          SizedBox(
            height: 20,
          ),
          const Text(
            'Company Registration Form',
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
                        .uploadFile('Company Logo\'s', formData['company_logo'])
                        .then((url) async {
                      formData['company_logo'] = url;
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(value.user.uid)
                          .set({
                        'email': formData['email'],
                        'phone_no': formData['company_phone'],
                        'name': formData['company_name']
                      }).then((userData) async {
                        await FirebaseFirestore.instance
                            .collection('compnay_record')
                            .doc(value.user.uid)
                            .set({
                          'company_logo': formData['company_logo'],
                          'company_name': formData['company_name'],
                          'complete_address': formData['complete_address'],
                          'city': formData['city'],
                          'province': formData['province'],
                          'terms&conditions': formData['terms&conditions'],
                          'industry': formData['industry'],
                        }).then((record) {
                          prefs!.setString('userDetails', jsonEncode(formData));
                          Navigator.of(context).pop();
                          Get.offAll(CompanyDashboard());
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
                            controller: email,
                            validator: (value) => Helper.validateEmail(value!),
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
                              controller: password,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'please enter your password';
                                } else {}
                                return null;
                              },
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
                              controller: conf_password,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'please enter your confirm password';
                                } else if (value != password.text) {
                                  return 'password doesn\'t match';
                                }
                                return null;
                              },
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
                  title: 'Company',
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
                                if (company_logo == null) {
                                  return 'please add company logo';
                                }
                                return null;
                              },
                              builder: (field) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: Column(
                                        children: [
                                          CircleAvatar(
                                            radius: 50,
                                            backgroundColor:
                                                AppColor.transparent,
                                            backgroundImage:
                                                company_logo != null
                                                    ? Image.file(
                                                        company_logo!,
                                                        fit: BoxFit.fill,
                                                      ).image
                                                    : Image.asset(
                                                        Kimages.logoIcon,
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
                                                      color:
                                                          AppColor.blackColor,
                                                      size: 16,
                                                    ),
                                                    alignment:
                                                        PlaceholderAlignment
                                                            .middle,
                                                  ),
                                                  TextSpan(
                                                    text:
                                                        " Upload Company Logo",
                                                    style: TextStyle(
                                                      color:
                                                          AppColor.blackColor,
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
                              }),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: company_name,
                            onChanged: (value) {
                              formData['company_name'] = value;
                            },
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'please enter your company name';
                              } else {}
                              return null;
                            },
                            decoration: const InputDecoration(
                              hintText: 'Compnay Name',
                              labelText: 'Company Name',
                            ),
                          ),
                          const SizedBox(height: 20),
                          InternationalPhoneNumberInput(
                            onInputChanged: (PhoneNumber number) {
                              formData['company_phone'] = number.phoneNumber;
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
                              hintText: 'Compnay Contact No.',
                              labelText: 'Compnay Contact No.',
                            ),
                          ),
                          const SizedBox(height: 20),
                          DropdownButtonFormField(
                            validator: (value) {
                              if (value == null) {
                                return 'please select industry blong with';
                              } else {}
                              return null;
                            },
                            onChanged: (value) {
                              formData['industry'] = value;
                            },
                            items: industries,
                            isDense: true,
                            decoration: const InputDecoration(
                                hintText: 'Industry',
                                labelText: 'Industry',
                                helperMaxLines: 5,
                                helperText:
                                    'Adding your industry helps to share more information about yourself and find more connections on RemoteHub, as well as to get recommendations about the jobs relevant for this industry.'),
                          ),
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
                          TextFormField(
                            controller: country,
                            onChanged: (value) {
                              formData['country'] = value;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'please enter your country name';
                              } else {}
                              return null;
                            },
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            enabled: false,
                            decoration: const InputDecoration(
                              hintText: 'Country',
                              labelText: 'Country',
                            ),
                          ),
                          const SizedBox(height: 20),
                          Obx(() {
                            return DropdownButtonFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'please select your province name';
                                } else {}
                                return null;
                              },
                              onChanged: (value) {
                                province.value = value;
                                readCities();
                                formData['province'] = value;
                              },
                              items: provinces,
                              iconSize: 0.0,
                              isDense: true,
                              decoration: const InputDecoration(
                                hintText: 'Province',
                                isDense: true,
                                labelText: 'Province',
                              ),
                            );
                          }),
                          const SizedBox(height: 20),
                          Obx(() {
                            return DropdownButtonFormField(
                              onChanged: (value) {
                                formData['city'] = value;
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'please select your city name';
                                } else {}
                                return null;
                              },
                              items: cities,
                              iconSize: 0.0,
                              isDense: true,
                              decoration: const InputDecoration(
                                hintText: 'City',
                                isDense: true,
                                labelText: 'City',
                              ),
                            );
                          }),
                          const SizedBox(height: 20),
                          TextFormField(
                            onChanged: (value) {
                              formData['complete_address'] = value;
                            },
                            controller: company_address,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'please enter your complete address';
                              } else {}
                              return null;
                            },
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.text,
                            minLines: 5,
                            maxLines: 6,
                            decoration: const InputDecoration(
                                hintText: 'Complete Address',
                                labelText: 'Complete Address',
                                helperMaxLines: 5,
                                helperText:
                                    'Adding compnay country, city and state or province helps to share more information about yourself and find more connections on RemoteHub. It will also help to get recommendations about local jobs available in your city, and match you with potential employers.'),
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
        company_logo = File(pickedFile.path);
        formData['company_logo'] = company_logo;
      });
    }
  }

  getFromCamera() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      setState(() {
        company_logo = File(pickedFile.path);
        formData['company_logo'] = company_logo;
      });
    }
  }
}
