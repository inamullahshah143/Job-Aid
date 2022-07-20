import 'package:cool_stepper_reloaded/cool_stepper_reloaded.dart';
import 'package:custom_check_box/custom_check_box.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:job_finding/router_name.dart';
import 'package:job_finding/utils/constants.dart';

import 'social_button.dart';

class RegisterContainer extends StatefulWidget {
  final String? userType;
  const RegisterContainer({Key? key, required this.userType}) : super(key: key);

  @override
  State<RegisterContainer> createState() => _RegisterContainerState();
}

class _RegisterContainerState extends State<RegisterContainer> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    final steps = [
      CoolStep(
        title: 'Basic Information',
        subtitle: 'Please fill some of the basic information to get started',
        alignment: Alignment.center,
        content: Column(
          children: [
            TextFormField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                hintText: 'Your Name',
                labelText: 'Your Name',
              ),
            ),
            const SizedBox(height: 20),
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
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
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
                Expanded(
                  child: RichText(
                    softWrap: true,
                    textAlign: TextAlign.start,
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 14,
                        color: blackColor,
                      ),
                      children: [
                        const TextSpan(
                            text:
                                'By creating account I\'m agree with job finding '),
                        TextSpan(
                          text: ' terms & condition',
                          recognizer: TapGestureRecognizer()..onTap = () {},
                          style: const TextStyle(
                            color: secondaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const TextSpan(text: ' and '),
                        TextSpan(
                          text: 'privacy policy',
                          recognizer: TapGestureRecognizer()..onTap = () {},
                          style: const TextStyle(
                            color: secondaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, Routes.home);
              },
              child: const Text("Register"),
            ),
            const Spacer(),
            const SocialButton(text: 'Or Register in with'),
            const SizedBox(height: 50),
          ],
        ),
      ),
    ];

    return Padding(
      padding: const EdgeInsets.only(top: 24, left: 20, right: 20),
      child: CoolStepper(
        showErrorSnackbar: true,
        hasRoundedCorner: true,
        onCompleted: _onFinish,
        contentPadding: const EdgeInsets.only(left: 40, right: 40),
        config: CoolStepperConfig(
          finishButton: ElevatedButton(
            child: const Text('Finish'),
            onPressed: () => {},
          ),
          backButton: ElevatedButton(
            child: const Text('Back'),
            onPressed: () => {},
          ),
          nextButton: ElevatedButton(
            child: const Text('\bNext\b'),
            onPressed: () => {},
          ),
        ),
        steps: steps,
      ),
    );
  }

  void _onFinish() {}
}
