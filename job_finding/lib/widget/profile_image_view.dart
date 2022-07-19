import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:job_finding/utils/constants.dart';

class ProfileImageView extends StatelessWidget {
  const ProfileImageView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 104,
          width: 104,
          decoration: BoxDecoration(
            color: circleColor,
            borderRadius: BorderRadius.circular(34),
          ),
        ),
        Positioned(
          right: -4,
          bottom: -4,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(8),
            child: Center(
              child: SvgPicture.asset('assets/icons/camera.svg'),
            ),
          ),
        ),
      ],
    );
  }
}
