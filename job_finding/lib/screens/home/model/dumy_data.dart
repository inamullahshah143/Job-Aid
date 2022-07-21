import 'dart:ui';
import 'package:job_finding/utils/k_images.dart';
import 'category_cart_model.dart';

final tagList = [
  "Software Engineer",
  "Web Developer",
  "UI Engineer",
  "UX Engineer",
  "Andriod Engineer",
  "IOS Engineer",
  "ASP .NET Engineer",
  "PHP Engineer",
  "Software Engineer",
  "Software Engineer",
];

final categoryList = [
  "Populer",
  "Latest",
  "Categories",
  "Upcoming",
];

List<CategoryCartModel> categoryCardList = [
  CategoryCartModel(
    id: 0,
    image: Kimages.figmaIcon,
    price: 10000,
    address: "Islamabad, Pakistan",
    title: "UX Desinger",
    tags: ["Full Time", "Remote"],
    color: const Color(0xff4FAA89),
  ),
  CategoryCartModel(
    id: 1,
    image: Kimages.shopifyIcon,
    price: 20000,
    address: "Lahore, Pakistan",
    title: "Web Desinger",
    tags: ["Full Time", "Remote"],
    color: const Color.fromARGB(255, 109, 108, 108),
  ),
  CategoryCartModel(
    id: 2,
    image: Kimages.shopifyIcon,
    price: 15000,
    address: "Karachi, Pakistan",
    title: "UI Desinger",
    tags: ["Full Time", "Remote"],
    color: const Color.fromARGB(255, 247, 224, 224),
  ),
];
