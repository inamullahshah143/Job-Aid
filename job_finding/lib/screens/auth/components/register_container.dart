import 'dart:convert';

import 'package:cool_stepper_reloaded/cool_stepper_reloaded.dart';
import 'package:custom_check_box/custom_check_box.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:job_finding/utils/constants.dart';
import 'package:text_chip_field/text_chip_field.dart';

class RegisterContainer extends StatefulWidget {
  final String? userType;
  const RegisterContainer({Key? key, required this.userType}) : super(key: key);

  @override
  State<RegisterContainer> createState() => _RegisterContainerState();
}

class _RegisterContainerState extends State<RegisterContainer> {
  bool isChecked = false;
  static List<String> languageList = [''];
  static List<String> levelList = [''];
  List<DropdownMenuItem> industries = [];
  List<DropdownMenuItem> countries = [];
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      readIndustries();
      readCountries();
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
                color: labelColor,
                fontSize: 12.0,
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
      CoolStep(
        alignment: Alignment.center,
        content: Column(
          children: [
            DropdownButtonFormField<dynamic>(
              onChanged: (value) {},
              items: countries,
              iconSize: 0.0,
              isDense: true,
              value: 'Pakistan',
              decoration: const InputDecoration(
                hintText: 'Country',
                isDense: true,
                labelText: 'Country',
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                hintText: 'City',
                labelText: 'City (Optional)',
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              'Adding your country, city and state or province helps to share more information about yourself and find more connections on RemoteHub. It will also help to get recommendations about local jobs available in your city, and match you with potential employers.',
              style: TextStyle(
                color: labelColor,
                fontSize: 12.0,
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                hintText: 'Website',
                labelText: 'Website (Optional)',
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              'If you have a website or a page representing you, we recommend adding it as it helps to share more information about yourself and your skills.',
              style: TextStyle(
                color: labelColor,
                fontSize: 12.0,
              ),
            ),
          ],
        ),
      ),
      CoolStep(
        alignment: Alignment.center,
        content: Column(
          children: [
            TextChipField(
              seprator: ",",
              spacing: 5,
              decoration: const InputDecoration(
                hintText: 'Skills',
                labelText: 'Skills',
              ),
              onChanged: (val) {},
            ),
            const SizedBox(height: 20),
            ...getLanguages(),
            const SizedBox(height: 20),
            const SizedBox(height: 5),
            const Text(
              'When you create an account, your country is automatically indicated on your profile from your geolocation. Please check that it accurately represents your current location, and edit it, if necessary. \n\nAdding your city and state or province helps to share more information about yourself and find more connections on RemoteHub. It will also help to get recommendations about local jobs available in your city, and match you with potential employers.',
              style: TextStyle(
                color: labelColor,
                fontSize: 12.0,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      CoolStep(
        alignment: Alignment.center,
        content: Column(
          children: [
            TextChipField(
              seprator: ",",
              spacing: 5,
              decoration: const InputDecoration(
                hintText: 'Skills',
                labelText: 'Skills',
              ),
              onChanged: (value) {},
            ),
            const SizedBox(height: 20),
            ...getLanguages(),
            const SizedBox(height: 20),
            const SizedBox(height: 5),
            const Text(
              'When you create an account, your country is automatically indicated on your profile from your geolocation. Please check that it accurately represents your current location, and edit it, if necessary. \n\nAdding your city and state or province helps to share more information about yourself and find more connections on RemoteHub. It will also help to get recommendations about local jobs available in your city, and match you with potential employers.',
              style: TextStyle(
                color: labelColor,
                fontSize: 12.0,
              ),
            ),
            const SizedBox(height: 20),
          ],
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

  Future readCountries() async {
    final String response =
        await rootBundle.loadString('assets/json/countries.json');
    final data = await json.decode(response);
    for (var item in data['data']) {
      countries.add(
        DropdownMenuItem(
          child: Text(
            item['title'],
          ),
          value: item['title'],
        ),
      );
    }
  }

  List<Widget> getLanguages() {
    List<Widget> languageTextFields = [];
    for (int i = 0; i < languageList.length; i++) {
      languageTextFields.add(
        Material(
          color: Colors.white,
          child: Row(
            children: [
              Flexible(
                child: LanguagesFields(index: i),
              ),
              const SizedBox(
                width: 10,
              ),
              Flexible(
                child: LevelFields(index: i),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: _addRemoveButton(i == languageList.length - 1, i),
              ),
            ],
          ),
        ),
      );
    }
    return languageTextFields;
  }

  Widget _addRemoveButton(bool add, int index) {
    return InkWell(
      onTap: () {
        if (add) {
          languageList.insert(0, '');
        } else {
          languageList.removeAt(index);
        }
        setState(() {});
      },
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: (add) ? secondaryColor : redColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          (add) ? Icons.add : Icons.remove,
          color: Colors.white,
        ),
      ),
    );
  }
}

class LanguagesFields extends StatefulWidget {
  final int index;

  const LanguagesFields({Key? key, required this.index}) : super(key: key);
  @override
  _LanguagesFieldsState createState() => _LanguagesFieldsState();
}

class _LanguagesFieldsState extends State<LanguagesFields> {
  String? languageController;

  @override
  void initState() {
    super.initState();
    languageController = '';
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      languageController = _RegisterContainerState.languageList[widget.index];
    });

    return TextFormField(
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        hintText: 'Language',
        labelText: 'Language',
      ),
      onChanged: (v) =>
          _RegisterContainerState.languageList[widget.index] = v.toString(),
      validator: (String? v) {
        if (v!.isEmpty) {
          return 'please select language';
        }
        return null;
      },
    );
  }
}

class LevelFields extends StatefulWidget {
  final int index;

  const LevelFields({Key? key, required this.index}) : super(key: key);
  @override
  _LevelFieldsState createState() => _LevelFieldsState();
}

class _LevelFieldsState extends State<LevelFields> {
  String? levelController;

  @override
  void initState() {
    super.initState();
    levelController = '';
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      levelController = _RegisterContainerState.levelList[widget.index];
    });

    return DropdownButtonFormField(
      iconSize: 0.0,
      isDense: true,
      items: const [
        DropdownMenuItem(
          child: Text('Level 1'),
          value: 'Level 1',
        ),
        DropdownMenuItem(
          child: Text('Level 2'),
          value: 'Level 2',
        ),
        DropdownMenuItem(
          child: Text('Level 3'),
          value: 'Level 3',
        ),
        DropdownMenuItem(
          child: Text('Level 4'),
          value: 'Level 4',
        ),
        DropdownMenuItem(
          child: Text('Level 5'),
          value: 'Level 5',
        ),
      ],
      onChanged: (v) =>
          _RegisterContainerState.levelList[widget.index] = v.toString(),
      decoration: const InputDecoration(
        hintText: 'Level',
        labelText: 'Level',
        isDense: true,
      ),
      validator: (String? v) {
        if (v!.isEmpty) {
          return 'please select level';
        }
        return null;
      },
    );
  }
}
