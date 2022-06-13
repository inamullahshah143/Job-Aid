import 'package:auto_size_text/auto_size_text.dart';
import 'package:custom_check_box/custom_check_box.dart';
import 'package:flutter/material.dart';
import 'package:job_finding/modules/auth/components/have_an_account_or_not_view.dart';
import 'package:job_finding/modules/auth/components/social_button.dart';
import 'package:job_finding/router_name.dart';
import 'package:job_finding/utils/constants.dart';

class LoginContainer extends StatefulWidget {
  const LoginContainer({Key? key}) : super(key: key);

  @override
  State<LoginContainer> createState() => _LoginContainerState();
}

class _LoginContainerState extends State<LoginContainer> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, left: 20, right: 20),
      child: Column(
        children: [
          TextFormField(
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: 'Your Email',
              labelText: 'Your Email',
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
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
              Navigator.pushReplacementNamed(context, Routes.home);
            },
            child: const Text("Log In"),
          ),
          const SizedBox(height: 16),
          HaveAnAccountOrNotView(isLogin: true, onPressed: () {}),
          const Spacer(),
          const SocialButton(text: 'Or log in with'),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
