import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:job_finding/screens/home/model/dumy_data.dart';
import 'package:job_finding/utils/constants.dart';
import 'package:job_finding/utils/k_images.dart';
import 'component/filtering_bottom_sheet_body.dart';
import 'component/search_custom_app_bar.dart';
import 'component/custom_toggle_button.dart';
import 'component/job_card_component.dart';

class SearchResultScreen extends StatefulWidget {
  const SearchResultScreen({Key? key}) : super(key: key);

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  final _popupController = CustomPopupMenuController();

  final filterTags = [
    'Taxila',
    'Ux Design',
    'Full Time',
    'WAH Cantt',
    'Ux Design',
    'Full Time',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          children: [
            const SearchCustomAppBar(),
            const SizedBox(height: 40),
            _buildSearchField(),
            const SizedBox(height: 16),
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: filterTags.length,
                itemBuilder: (context, index) =>
                    _filterTagCard(filterTags[index]),
              ),
            ),
            const SizedBox(height: 24),
            _buildJobFoundAndSorting(),
            const SizedBox(height: 16),
            CustomToggleButton(
              onTap: (int v) {
                // print(v);
              },
              label: const ["Relevent", "Recent"],
              isFirst: 0,
            ),
            const SizedBox(height: 16),
            const JobCardComponent(
              address: "Taxila, Pakistan",
              tags: ["Full time", "In House", "Experience : 3y"],
              title: "Product Design",
            ),
            const JobCardComponent(
              address: "Taxila, Pakistan",
              tags: ["Full time", "In House", "Experience : 3y"],
              title: "UX Design",
            ),
            const JobCardComponent(
              address: "Taxila, Pakistan",
              tags: ["Full time", "In House", "Experience : 3y"],
              title: "UX Design",
            ),
            const JobCardComponent(
              address: "Taxila, Pakistan",
              tags: ["Full time", "In House", "Experience : 3y"],
              title: "UX Design",
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
      // bottomSheet: _buildBottomSheetBody(),
    );
  }

  Widget _filterTagCard(String text) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: boarderColor, borderRadius: BorderRadius.circular(14)),
      child: Row(
        children: [
          Text(text),
          const SizedBox(width: 10),
          const Icon(Icons.close_outlined, size: 14),
        ],
      ),
    );
  }

  Widget _buildJobFoundAndSorting() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "56 Job Found",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        CustomPopupMenu(
          child: Row(
            children: const [
              Text(
                "Latest",
                style: TextStyle(
                    fontSize: 12,
                    color: secondaryColor,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(width: 8),
              Icon(Icons.keyboard_arrow_down_outlined, color: secondaryColor)
            ],
          ),
          menuBuilder: () => ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Container(
              width: 200,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: tagList
                    .map(
                      (e) => InkWell(
                        onTap: () {
                          _popupController.hideMenu();
                        },
                        child: Container(
                          color: Colors.grey.shade300,
                          padding: const EdgeInsets.all(4.0),
                          margin: const EdgeInsets.all(4.0),
                          child: Text(e),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
          pressType: PressType.singleClick,
          verticalMargin: -10,
          controller: _popupController,
        ),
      ],
    );
  }

  Widget _buildSearchField() {
    return TextFormField(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      style: const TextStyle(color: secondaryColor),
      decoration: InputDecoration(
        border: const UnderlineInputBorder(
          borderSide: BorderSide(color: boarderColor),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: boarderColor),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: boarderColor),
        ),
        fillColor: Colors.transparent,
        filled: true,
        hintText: "Search here…",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIconConstraints:
            const BoxConstraints(maxHeight: 40, maxWidth: 40),
        suffixIconConstraints:
            const BoxConstraints(maxHeight: 40, maxWidth: 40),
        prefixIcon: Container(
          height: 24,
          width: 24,
          margin: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            color: secondaryColor,
            shape: BoxShape.circle,
          ),
        ),
        suffixIconColor: secondaryColor,
        suffixIcon: InkWell(
          onTap: () {
            _showSheet();
          },
          child: Container(
            margin: const EdgeInsets.only(right: 8),
            child: SvgPicture.asset(
              Kimages.filterIcon,
              height: 18,
              width: 18,
              color: secondaryColor,
            ),
          ),
        ),
        hintStyle: const TextStyle(color: secondaryColor),
      ),
    );
  }

  void _showSheet() {
    double maxHeight = .8;
    showStickyFlexibleBottomSheet<void>(
      bodyBuilder: (context, offset) {
        return SliverChildListDelegate([const FilteringBottomSheetBody()]);
      },
      anchors: [.2, 0.5, maxHeight],
      minHeight: 0,
      initHeight: 0.5,
      maxHeight: maxHeight,
      headerHeight: 46,
      context: context,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40.0),
          topRight: Radius.circular(40.0),
        ),
      ),
      headerBuilder: (context, offset) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: double.infinity,
          height: 46,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(offset == maxHeight ? 0 : 40),
              topRight: Radius.circular(offset == maxHeight ? 0 : 40),
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 12),
              SvgPicture.asset(Kimages.lineIcon),
            ],
          ),
        );
      },
    );
  }
}
