import 'package:flutter/material.dart';
import 'package:job_aid/theme/colors.dart';

class BottomMenuBar extends StatefulWidget {
  const BottomMenuBar({Key key}) : super(key: key);

  @override
  _BottomMenuBarState createState() => _BottomMenuBarState();
}

class _BottomMenuBarState extends State<BottomMenuBar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: BottomAppBar(
        child: Row(
          children: [
            Expanded(
              child: IconButton(
                icon: const Icon(Icons.home_outlined, color: KColors.primary),
                onPressed: () {},
              ),
            ),
            Expanded(
              child: IconButton(
                icon: const Icon(Icons.bookmark_border_rounded, color: KColors.icon),
                onPressed: () {},
              ),
            ),
            Expanded(
              child: IconButton(
                icon: const Icon(Icons.person_outline_rounded, color: KColors.icon),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
