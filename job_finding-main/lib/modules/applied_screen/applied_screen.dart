import 'package:flutter/material.dart';
import 'package:job_finding/modules/search/component/search_custom_app_bar.dart';
import 'package:job_finding/modules/search/component/custom_toggle_button.dart';
import 'package:job_finding/modules/search/component/job_card_component.dart';
import 'package:job_finding/utils/constants.dart';
import 'package:job_finding/utils/k_images.dart';

class AppliedScreen extends StatefulWidget {
  const AppliedScreen({Key? key}) : super(key: key);

  @override
  State<AppliedScreen> createState() => _AppliedScreenState();
}

class _AppliedScreenState extends State<AppliedScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          children: [
            const SearchCustomAppBar(text: 'Applications', isBackShow: false),
            const SizedBox(height: 24),
            CustomToggleButton(
              onTap: (int v) {
                _currentIndex = v;
                setState(() {});
              },
              label: const ["Applied", "Interviews"],
              isFirst: _currentIndex,
            ),
            if (_currentIndex == 0) _appliedList(),
            if (_currentIndex != 0) _notAppliedList(),
          ],
        ),
      ),
    );
  }

  Widget _notAppliedList() {
    return Column(
      children: [
        const SizedBox(height: 100),
        Image.asset(Kimages.noInterviewImage),
        const SizedBox(height: 24),
        const Text(
          "No Schedule",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 24),
        const Text("There is no job interviews set yet",
            style: TextStyle(fontSize: 14, color: labelColor))
      ],
    );
  }

  Column _appliedList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        SizedBox(height: 16),
        Text(
          "04 Applied Found",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        JobCardComponent(
          address: "Dhaka, Bangladesh",
          tags: ["Full time", "In House", "Experience : 3y"],
          title: "Product Design",
        ),
        JobCardComponent(
          address: "Dhaka, Bangladesh",
          tags: ["Full time", "In House", "Experience : 3y"],
          title: "UX Design",
        ),
        JobCardComponent(
          address: "Dhaka, Bangladesh",
          tags: ["Full time", "In House", "Experience : 3y"],
          title: "UX Design",
        ),
        JobCardComponent(
          address: "Dhaka, Bangladesh",
          tags: ["Full time", "In House", "Experience : 3y"],
          title: "UX Design",
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
