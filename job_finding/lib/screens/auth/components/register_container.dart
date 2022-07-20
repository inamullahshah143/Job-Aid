import 'dart:convert';

import 'package:cool_stepper_reloaded/cool_stepper_reloaded.dart';
import 'package:custom_check_box/custom_check_box.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:job_finding/utils/constants.dart';

class RegisterContainer extends StatefulWidget {
  final String? userType;
  const RegisterContainer({Key? key, required this.userType}) : super(key: key);

  @override
  State<RegisterContainer> createState() => _RegisterContainerState();
}

class _RegisterContainerState extends State<RegisterContainer> {
  bool isChecked = false;
  List<DropdownMenuItem> industries = [
    const DropdownMenuItem(
      child: Text(''),
      value: '',
    )
  ];
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      readIndustries();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final steps = [
      CoolStep(
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
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                hintText: 'Your Phone No.',
                labelText: 'Your Phone No.',
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'Password',
                labelText: 'Password',
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'Confirm Password',
                labelText: 'Confirm Password',
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
          ],
        ),
      ),
      CoolStep(
        alignment: Alignment.center,
        content: Column(
          children: [
            TextFormField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                hintText: 'Headline',
                labelText: 'Headline',
                helperText: 'Example: Senior UI/UX designer',
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              'Your profile headline is an opportunity to share in a few words your occupation, interests, or other information which you want to highlight about yourself.',
              style: TextStyle(
                color: labelColor,
                fontSize: 12.0,
              ),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<dynamic>(
              onChanged: (value) {},
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
                color: labelColor,
                fontSize: 12.0,
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              maxLines: 6,
              minLines: 5,
              decoration: const InputDecoration(
                  hintText: 'About',
                  labelText: 'About',
                  helperText:
                      'Example: I\'m a Digital Marketing Specialist with 5 years of experience'),
            ),
            const SizedBox(height: 5),
            const Text(
              'Provide details about yourself, your work interest, and your strong sides.',
              style: TextStyle(
                color: labelColor,
                fontSize: 12.0,
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
      CoolStep(
        content: Column(
          children: const [],
        ),
      ),
    ];

    return CoolStepper(
      showErrorSnackbar: true,
      hasRoundedCorner: false,
      isHeaderEnabled: false,
      onCompleted: _onFinish,
      contentPadding: const EdgeInsets.only(left: 40, right: 40),
      config: CoolStepperConfig(
        stepColor: Colors.white,
        headerColor: Colors.transparent,
        finishButton: MaterialButton(
          child: const Text('Finish'),
          onPressed: () => {},
        ),
        backButton: MaterialButton(
          child: const Text('Back'),
          onPressed: () => {},
        ),
        nextButton: MaterialButton(
          child: const Text('\bNext\b'),
          onPressed: () => {},
        ),
      ),
      steps: steps,
    );
  }

  void _onFinish() {}
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
}
