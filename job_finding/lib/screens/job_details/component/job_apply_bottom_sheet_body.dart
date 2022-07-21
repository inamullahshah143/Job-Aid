import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:job_finding/screens/apply_process/apply_process.dart';
import 'package:job_finding/utils/constants.dart';
import 'package:job_finding/utils/k_images.dart';
import 'package:job_finding/utils/utils.dart';

class JobApplyBottomSheetBody extends StatelessWidget {
  const JobApplyBottomSheetBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          _header(),
          const SizedBox(height: 24),
          const Text("Name",
              style: TextStyle(fontSize: 16, color: paragraphColor)),
          const SizedBox(height: 8),
          TextFormField(
            keyboardType: TextInputType.name,
            decoration: const InputDecoration(
              fillColor: fillColor,
              hintText: 'name',
            ),
          ),
          const SizedBox(height: 16),
          const Text("Email",
              style: TextStyle(fontSize: 16, color: paragraphColor)),
          const SizedBox(height: 8),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              fillColor: fillColor,
              hintText: 'email',
            ),
          ),
          const SizedBox(height: 16),
          const Text("Phone",
              style: TextStyle(fontSize: 16, color: paragraphColor)),
          const SizedBox(height: 8),
          TextFormField(
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              fillColor: fillColor,
              hintText: 'Phone',
            ),
          ),
          const SizedBox(height: 16),
          const Text("Country",
              style: TextStyle(fontSize: 16, color: paragraphColor)),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: fillColor,
            ),
            child: CountryCodePicker(
              onChanged: print,
              // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
              initialSelection: 'BD',
              favorite: const ['+880', 'BD'],

              // optional. Shows only country name and flag
              showCountryOnly: false,
              // optional. Shows only country name and flag when popup is closed.
              showOnlyCountryWhenClosed: true,
              // optional. aligns the flag and the Text left
              alignLeft: false,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Cv",
                        style: TextStyle(fontSize: 16, color: paragraphColor)),
                    const SizedBox(height: 8),
                    TextFormField(
                      decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.note_add_outlined,
                              color: secondaryColor),
                          hintText: "+Upload",
                          fillColor: fillColor),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Portfolio/Link",
                        style: TextStyle(fontSize: 16, color: paragraphColor)),
                    const SizedBox(height: 8),
                    TextFormField(
                      decoration: const InputDecoration(
                          hintText: "url", fillColor: fillColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          ElevatedButton(
              onPressed: () {
                Utils.showCustomDialog(
                  context,
                  ApplyProcessView(
                    onChanged: (value) {
                      if (value == 10) {
                        Navigator.pop(context);
                      }
                    },
                  ),
                );
              },
              child: const Text("Apply")),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Row _header() {
    return Row(
      children: [
        Container(
          height: 64,
          width: 64,
          decoration: BoxDecoration(
            color: fillColor,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Center(child: SvgPicture.asset(Kimages.uiLeadIcon)),
        ),
        const SizedBox(width: 8),
        Column(
          children: const [
            Text(
              "UI Designer",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              "Taxila, Pakistan",
              style: TextStyle(fontSize: 12, color: paragraphColor),
            )
          ],
        )
      ],
    );
  }
}
