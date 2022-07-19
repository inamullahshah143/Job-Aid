import 'package:flutter/material.dart';
import 'package:job_finding/screens/home/component/job_applied_component.dart';
import 'package:job_finding/screens/options/option_view.dart';
import 'package:job_finding/router_name.dart';
import 'package:job_finding/utils/utils.dart';
import 'component/category_component.dart';
import 'package:job_finding/utils/constants.dart';
import 'package:job_finding/utils/k_images.dart';

import 'component/tag_component.dart';
import 'model/dumy_data.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:badges/badges.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        children: [
          _buildAppbar(context),
          _getPaddingChild(
            child: const Text(
              "Search,\nFind & Apply",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800),
            ),
          ),
          const SizedBox(height: 16),
          _buildSearchField(context),
          const SizedBox(height: 24),
          TagListComponent(item: tagList),
          const SizedBox(height: 40),
          CategoryComponent(
              catList: categoryList, categoryCartList: categoryCardList),
          const SizedBox(height: 20),
          const JobAppliedComponent(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSearchField(context) {
    return _getPaddingChild(
      child: TextFormField(
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
          suffixIcon: GestureDetector(
            onTap: () => Navigator.pushNamed(context, Routes.search),
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
      ),
    );
  }

  Widget _getPaddingChild({required Widget child}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: child,
    );
  }

  Widget _buildAppbar(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Utils.showCustomDialog(
                context,
                const OptionView(),
                onTap: () => Navigator.pop(context),
              );
            },
            child: Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                color: boarderColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(child: SvgPicture.asset(Kimages.drawerIcon)),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, Routes.notificationScreen);
            },
            child: Badge(
              badgeContent: const Text(''),
              position: BadgePosition.topEnd(end: 0, top: -10),
              child: SvgPicture.asset(
                Kimages.notificationIcon,
                height: 24,
                width: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
