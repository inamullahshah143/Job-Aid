import 'package:flutter/material.dart';
import 'package:job_finding/utils/constants.dart';

class TagListComponent extends StatelessWidget {
  const TagListComponent({
    Key? key,
    required this.item,
  }) : super(key: key);

  final List<String> item;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, int index) {
          return _buildItem(index);
        },
        itemCount: item.length,
      ),
    );
  }

  Widget _buildItem(int index) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
          color: boarderColor, borderRadius: BorderRadius.circular(14)),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      child: Center(
        child: Text(
          item[index],
          style: const TextStyle(fontSize: 14),
        ),
      ),
    );
  }
}
