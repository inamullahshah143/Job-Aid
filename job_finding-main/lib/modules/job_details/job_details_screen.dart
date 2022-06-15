import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:job_finding/modules/job_details/component/job_custom_app_bar.dart';
import 'package:job_finding/modules/job_details/model/jobdetails_dymy_data.dart';
import 'package:job_finding/utils/constants.dart';
import 'package:job_finding/utils/k_images.dart';
import 'package:job_finding/widget/teg_text.dart';
import '../home/component/category_line_indicator_text.dart';
import 'component/company_component.dart';
import 'component/job_apply_bottom_sheet_body.dart';
import 'component/job_details_header.dart';
import 'component/populer_component.dart';
import 'component/requirements_component.dart';
import 'component/review_component.dart';

class JobDetailsScreen extends StatefulWidget {
  const JobDetailsScreen({Key? key}) : super(key: key);

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  int _currentIndex = 3;
  final List<Widget> _widgetList = const [
    PopulerComponent(),
    RequirementsComponent(requirementList: jobRequirementList),
    CompanyComponent(),
    ReviewComponent(),
  ];

  List jobPreviewList = ["Description", 'Requirements', "Company", 'Reviews'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      body: SafeArea(
        child: ListView(
          children: [
            const SizedBox(height: 16),
            JobCustomAppBar(
                text: "Job Details", bgColor: Colors.white.withOpacity(0.15)),
            const SizedBox(height: 24),
            _buildDetailsCard(),
            const SizedBox(height: 30),
            const SizedBox(height: 30),
            Container(
              constraints: const BoxConstraints(minHeight: 500),
              padding: const EdgeInsets.symmetric(vertical: 30),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    height: 30,
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      scrollDirection: Axis.horizontal,
                      itemCount: jobPreviewList.length,
                      itemBuilder: (_, index) => CategoryLineIndecatorText(
                        isCurrentItem: _currentIndex == index,
                        index: index,
                        text: jobPreviewList[index],
                        onTap: (int i) {
                          setState(() {
                            _currentIndex = i;
                          });
                        },
                      ),
                    ),
                  ),
                  _widgetList[_currentIndex],
                  const SizedBox(height: 70),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Flexible(
              child: ElevatedButton(
                  onPressed: () {
                    _showSheet();
                  },
                  child: const Text("Apply")),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(56, 56),
                maximumSize: const Size(56, 56),
              ),
              child: SvgPicture.asset(
                Kimages.messageIcon,
                height: 24,
                width: 24,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding _buildDetailsCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const JobDetailsHeader(),
          const SizedBox(height: 22),
          _buildTagAndSalary(),
        ],
      ),
    );
  }

  Row _buildTagAndSalary() {
    return Row(
      children: [
        ...["Full time", "In House", "Experience : 3y"]
            .take(3)
            .map(
              (e) => TagText(
                text: e,
                textColor: Colors.white,
                bgColor: Colors.white.withOpacity(.15),
              ),
            )
            .toList(),
        const Spacer(),
        Text.rich(
          TextSpan(
            text: "\$12",
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
            children: [
              TextSpan(
                text: "/m",
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withOpacity(0.8),
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showSheet() {
    double headerHeight = 72;
    double maxHeight = .8;
    showStickyFlexibleBottomSheet<void>(
      bodyBuilder: (context, offset) {
        return SliverChildListDelegate([const JobApplyBottomSheetBody()]);
      },
      anchors: [.2, 0.5, maxHeight],
      minHeight: 0,
      initHeight: 0.5,
      maxHeight: maxHeight,
      headerHeight: headerHeight,
      context: context,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(headerHeight / 2)),
      ),
      headerBuilder: (context, offset) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: headerHeight,
          margin: const EdgeInsets.only(top: 0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft:
                  Radius.circular(offset == maxHeight ? 0 : headerHeight / 2),
              topRight:
                  Radius.circular(offset == maxHeight ? 0 : headerHeight / 2),
            ),
          ),
          child: Container(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Apply Form",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 48,
                    width: 48,
                    child: const Icon(Icons.close),
                    decoration: BoxDecoration(
                        color: boarderColor,
                        borderRadius: BorderRadius.circular(16)),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
