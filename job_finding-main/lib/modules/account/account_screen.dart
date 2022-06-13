import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:job_finding/modules/account/components/skill_item_view.dart';
import 'package:job_finding/router_name.dart';
import 'package:job_finding/utils/constants.dart';
import 'package:job_finding/widget/appbar_button.dart';
import 'package:job_finding/widget/profile_image_view.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 12,
        title: const Text(
          'Account',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, Routes.profileScreen);
            },
            child: const AppbarButton(icon: 'assets/icons/edit.svg'),
          ),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                Row(
                  children: [
                    const ProfileImageView(),
                    const SizedBox(width: 24),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Ferdous Islam',
                            style: TextStyle(
                              color: blackColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              _buildIcon('assets/icons/call.svg'),
                              _buildIcon('assets/icons/message2.svg'),
                              _buildIcon('assets/icons/location.svg'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Divider(
                  thickness: 1,
                  color: labelColor.withOpacity(0.3),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildAccountText('98', 'Applied'),
                    _buildAccountText('73', 'Reviewed'),
                    _buildAccountText('10', 'Contacted'),
                  ],
                ),
                const SizedBox(height: 40),
                const Text(
                  'Resume',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: textColor,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 12),
                  decoration: BoxDecoration(
                    color: labelColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'ferdous_resume.pdf',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: captionTextColor,
                          ),
                        ),
                      ),
                      SvgPicture.asset('assets/icons/download2.svg'),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                const Text(
                  'Skills',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    SkillItemView(
                      icon: 'assets/images/figma.png',
                      text: 'Figma',
                      percent: '95%',
                      color: skillsColorOne,
                    ),
                    SkillItemView(
                      icon: 'assets/images/xd.png',
                      text: 'Adobe XD',
                      percent: '80%',
                      color: skillsColorTwo,
                    ),
                    SkillItemView(
                      icon: 'assets/images/photoshop.png',
                      text: 'Photoshop',
                      percent: '90%',
                      color: skillsColorThree,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Column _buildAccountText(String number, String text) {
    return Column(
      children: [
        Text(
          number,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: textColor,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 12,
            color: captionTextColor,
          ),
        ),
      ],
    );
  }

  Container _buildIcon(String icon) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: labelColor.withOpacity(0.3),
        ),
      ),
      child: Center(
        child: SvgPicture.asset(
          icon,
          color: blackColor,
        ),
      ),
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(right: 12),
    );
  }
}
