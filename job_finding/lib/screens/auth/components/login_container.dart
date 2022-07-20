import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_check_box/custom_check_box.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:job_finding/helper/auth_helper.dart';
import 'package:job_finding/helper/helper.dart';
import 'package:job_finding/main.dart';
import 'package:job_finding/router_name.dart';
import 'package:job_finding/screens/auth/components/social_button.dart';
import 'package:job_finding/utils/constants.dart';
import 'package:job_finding/widget/components.dart';

class LoginContainer extends StatefulWidget {
  final String? userType;
  const LoginContainer({Key? key, required this.userType}) : super(key: key);

  @override
  State<LoginContainer> createState() => _LoginContainerState();
}

class _LoginContainerState extends State<LoginContainer> {
  bool isChecked = false;
  final formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  void initState() {
    if (kDebugMode) {
      print(widget.userType);
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, left: 20, right: 20),
      child: Form(
        key: formKey,
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
                  borderColor: blackColor,
                  checkedFillColor: isChecked ? blackColor : primaryColor,
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
                    color: blackColor,
                  ),
                  maxFontSize: 16,
                  minFontSize: 14,
                  maxLines: 1,
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {},
                  child: const AutoSizeText(
                    'Forgot Password?',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: secondaryColor,
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
              onPressed: () {
                AuthenticationHelper()
                    .signIn(
                        email: email.text,
                        context: context,
                        password: password.text)
                    .then((result) {
                  if (result != null) {
                    FirebaseFirestore.instance
                        .collection('user')
                        .doc(result.user.uid)
                        .get()
                        .then((value) async {
                      prefs!.setString('Username', value.data()!['username']);
                      prefs!.setString('UserID', result.user.uid);
                      prefs!.setString('Email', value.data()!['email']);
                      prefs!.setString('PhoneNo', value.data()!['phone_no']);
                      Navigator.of(context).pop();
                      Components.showSnackBar(context, 'Wellcome back');
                      Navigator.pushReplacementNamed(context, Routes.home);
                    });
                  }
                }).catchError((e) {
                  Components.showSnackBar(context, e);
                  Navigator.of(context).pop();
                });
              },
              child: const Text("Sign In"),
            ),
            const Spacer(),
            const SocialButton(text: 'Or log in with'),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
