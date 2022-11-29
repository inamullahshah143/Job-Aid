import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_check_box/custom_check_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:job_aid/auth/auth_type.dart';
import 'package:job_aid/auth/candidate_registration/candidate_registration.dart';
import 'package:job_aid/auth/company_registration/company_registration.dart';
import 'package:job_aid/auth/forget_password.dart';
import 'package:job_aid/constants/k_images.dart';
import 'package:job_aid/main.dart';
import 'package:job_aid/screens/candidate_home/candidate_dashboard.dart';
import 'package:job_aid/screens/company_home/company_dashboard.dart';
import 'package:job_aid/utils/auth_helper.dart';
import 'package:job_aid/utils/helper.dart';
import 'package:simple_shadow/simple_shadow.dart';

import '../constants/colors.dart';
import '../constants/components.dart';

class LoginScreen extends StatefulWidget {
  final String userType;
  const LoginScreen({super.key, required this.userType});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isChecked = false;

  final formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Map<String, dynamic>? user;

  @override
  void initState() {
    super.initState();
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
            Get.offAll(AuthType());
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            size: 18,
          ),
        ),
      ),
      body: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(height: 50),
            SimpleShadow(
              opacity: 0.25,
              color: Colors.black,
              offset: const Offset(2, 2),
              sigma: 2,
              child: Image.asset(
                Kimages.logoBlackIcon,
                width: MediaQuery.of(context).size.width / 2.25,
                height: MediaQuery.of(context).size.width / 2.25,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: email,
                    validator: (value) => Helper.validateEmail(value!),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: 'Your Email',
                      labelText: 'Your Email',
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: password,
                    validator: (value) => Helper.validatePassword(value!),
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: 'Password',
                      labelText: 'Password',
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      CustomCheckBox(
                        value: isChecked,
                        shouldShowBorder: true,
                        borderColor: AppColor.blackColor,
                        checkedFillColor: isChecked
                            ? AppColor.blackColor
                            : AppColor.primaryColor,
                        borderRadius: 4,
                        borderWidth: 2,
                        checkBoxSize: 16,
                        onChanged: (value) {
                          setState(() {
                            isChecked = value;
                          });
                        },
                      ),
                      const AutoSizeText(
                        'Remember Me',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: AppColor.blackColor,
                        ),
                        maxFontSize: 16,
                        minFontSize: 14,
                        maxLines: 1,
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          Get.to( ForgetPassword());
                        },
                        child: const AutoSizeText(
                          'Forgot Password?',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: AppColor.primaryColor,
                          ),
                          maxFontSize: 16,
                          minFontSize: 14,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          AppColor.primaryColor),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(AppColor.white),
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
                      if (widget.userType == 'Company') {
                        AuthenticationHelper()
                            .signIn(email: email.text, password: password.text)
                            .then((result) {
                          if (result != null) {
                            FirebaseFirestore.instance
                                .collection('users')
                                .doc(result.user.uid)
                                .get()
                                .then((userData) async {
                              user = userData.data();
                              FirebaseFirestore.instance
                                  .collection('compnay_record')
                                  .doc(result.user.uid)
                                  .get()
                                  .then((companyData) async {
                                user!.addAll(companyData.data()!);
                                prefs!
                                    .setString('userDetails', jsonEncode(user));
                                Components.showSnackBar(
                                    context, 'Welcome back');
                                Get.offAll(CompanyDashboard());
                              }).catchError((e) {
                                Components.showSnackBar(context, e);
                                Navigator.of(context).pop();
                              });
                            }).catchError((e) {
                              Components.showSnackBar(context, e);
                              Navigator.of(context).pop();
                            });
                          }
                        }).catchError((e) {
                          Components.showSnackBar(context, e.toString());
                          Navigator.of(context).pop();
                        });
                      } else {
                        AuthenticationHelper()
                            .signIn(email: email.text, password: password.text)
                            .then((result) async {
                          if (result != null) {
                            await FirebaseFirestore.instance
                                .collection('users')
                                .doc(result.user.uid)
                                .get()
                                .then((userData) async {
                              user = userData.data();
                              await FirebaseFirestore.instance
                                  .collection('user_record')
                                  .doc(result.user.uid)
                                  .get()
                                  .then((userData) async {
                                user!.addAll(userData.data()!);
                                prefs!
                                    .setString('userDetails', jsonEncode(user));
                                Components.showSnackBar(
                                    context, 'Welcome back');
                                Get.offAll(CandidateDashboard());
                              }).catchError((e) {
                                Components.showSnackBar(context, e.toString());
                                Navigator.of(context).pop();
                              });
                            }).catchError((e) {
                              Components.showSnackBar(context, e);
                              Navigator.of(context).pop();
                            });
                          }
                        }).catchError((e) {
                          Components.showSnackBar(context, e);
                          Navigator.of(context).pop();
                        });
                      }
                    },
                    child: const Text("Sign In"),
                  ),
                ],
              ),
            ),
            HaveAnAccountOrNotView(
              isLogin: true,
              onPressed: () {
                if (widget.userType == 'Company') {
                  Get.to(const CompanyRegistration());
                } else {
                  Get.to(CandidateRegistration());
                }
              },
            ),
            const SocialButton(text: 'Or log in with'),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

 
}

class SocialButton extends StatelessWidget {
  const SocialButton({
    Key? key,
    required this.text,
    this.onTapFacebook,
    this.onTapGoogle,
  }) : super(key: key);

  final String text;
  final VoidCallback? onTapGoogle;
  final VoidCallback? onTapFacebook;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: AppColor.blackColor,
          ),
        ),
        const SizedBox(width: 40),
        InkWell(
          onTap: onTapGoogle,
          child: SvgPicture.asset('assets/icons/google_logo.svg'),
        ),
        const SizedBox(width: 20),
        InkWell(
          onTap: onTapFacebook,
          child: SvgPicture.asset('assets/icons/facebook_logo.svg'),
        ),
      ],
    );
  }
}

class HaveAnAccountOrNotView extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isLogin;

  const HaveAnAccountOrNotView(
      {Key? key, this.onPressed, required this.isLogin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          isLogin ? 'Don\'t Have Account?' : 'Already Have an account?',
          style: Theme.of(context).textTheme.subtitle1!.copyWith(
                fontWeight: FontWeight.w800,
                color: AppColor.blackColor,
              ),
        ),
        TextButton(
          onPressed: onPressed,
          child: Text(
            !isLogin ? 'Log In' : 'Register',
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColor.primaryColor,
                ),
          ),
        )
      ],
    );
  }
}
