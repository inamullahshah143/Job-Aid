import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:job_finding/utils/utils.dart';
import 'package:job_finding/widget/teg_text.dart';
import '../model/category_cart_model.dart';
import 'category_line_indicator_text.dart';

class CategoryComponent extends StatefulWidget {
  const CategoryComponent(
      {Key? key, required this.categoryCartList, required this.catList})
      : super(key: key);
  final List<String> catList;
  final List<CategoryCartModel> categoryCartList;

  @override
  State<CategoryComponent> createState() => _CategoryComponentState();
}

class _CategoryComponentState extends State<CategoryComponent> {
  final controller = ScrollController();

  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 12),
          height: 34,
          child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              scrollDirection: Axis.horizontal,
              itemCount: widget.catList.length,
              itemBuilder: (_, index) => CategoryLineIndecatorText(
                    isCurrentItem: _currentIndex == index,
                    text: widget.catList[index],
                    index: index,
                    onTap: (int i) {
                      setState(() {
                        _currentIndex = i;
                      });
                    },
                  )),
        ),
        SizedBox(
          height: 190,
          child: ListView.builder(
            itemBuilder: (context, index) =>
                _categoryCartitem(widget.categoryCartList[index]),
            itemCount: widget.categoryCartList.length,
            itemExtent: (size.width * 0.66) + 24,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            scrollDirection: Axis.horizontal,
            controller: controller,
          ),
        ),
      ],
    );
  }

  Widget _categoryCartitem(CategoryCartModel item) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      margin: const EdgeInsets.only(bottom: 20, left: 12, right: 12),
      decoration: BoxDecoration(
        color: item.color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: item.color.withOpacity(.4),
            offset: const Offset(4, 8),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _cartheader(item),
          const SizedBox(height: 12),
          Text(
            item.title,
            style: const TextStyle(
                fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Text(
            item.address,
            style: const TextStyle(
                fontSize: 12,
                height: 1.7,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                TagText(
                  text: item.tags.first,
                  textColor: Colors.white,
                ),
                TagText(
                  text: item.tags.last,
                  textColor: Colors.white,
                ),
              ]),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {},
                  child: const Icon(Icons.bookmark_border_outlined,
                      color: Colors.white),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _cartheader(CategoryCartModel item) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Center(child: SvgPicture.asset(item.image, height: 24)),
        ),
        Text.rich(
          TextSpan(
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
            text: Utils.formatPrice(item.price),
            children: const [
              TextSpan(
                text: "/m",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ),
            ],
          ),
        )
      ],
    );
  }
}
