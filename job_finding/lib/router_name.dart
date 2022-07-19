import 'package:flutter/material.dart';
import 'package:job_finding/screens/account/account_screen.dart';
import 'package:job_finding/screens/auth/auth_screen.dart';
import 'package:job_finding/screens/faq/faq_screen.dart';
import 'package:job_finding/screens/home/home_page.dart';
import 'package:job_finding/screens/notification/notification_screen.dart';
import 'package:job_finding/screens/notification/notification_setting_screen.dart';
import 'package:job_finding/screens/profile/profile_screen.dart';
import 'package:job_finding/screens/setting/setting_screen.dart';
import 'package:job_finding/screens/splash/continue_as_screen.dart';
import 'package:job_finding/screens/splash/splash_screen.dart';
import 'screens/applied_screen/applied_screen.dart';
import 'screens/job_details/job_details_screen.dart';
import 'screens/message/chat_list_screen.dart';
import 'screens/message/chat_screen.dart';
import 'screens/search/search_init_screen.dart';
import 'screens/search/search_result_screen.dart';

class Routes {
  static const String home = '/';

  static String search = "/searchInit";
  static String searchResult = "/searchResult";
  static String appliedScreen = "/appliedScreen";
  static String chatListScreen = "/chatListScreen";
  static String chatScreen = "/chatScreen";
  static String jobDetailsScreen = "/jobDetailsScreen";
  static String splashScreen = "/splashScreen";
  static String continueAsScreen = "/continueAsScreen";
  static String authScreen = "/authScreen";
  static String accountScreen = "/accountScreen";
  static String profileScreen = "/ProfileScreen";
  static String notificationSettingScreen = "/notificationSettingScreen";
  static String notificationScreen = "/notificationScreen";
  static String settingScreen = "/settingScreen";
  static String faqScreen = "/faqScreen";

  static final Map<String, WidgetBuilder> routes = {
    home: (context) => const HomeScreen(),
    splashScreen: (context) => const SplashScreen(),
    continueAsScreen: (context) => const ContinueAsScreen(),
    authScreen: (context) => const AuthScreen(),
    accountScreen: (context) => const AccountScreen(),
    profileScreen: (context) => const ProfileScreen(),
    notificationSettingScreen: (context) => const NotificationSettingScreen(),
    notificationScreen: (context) => const NotificationScreen(),
    faqScreen: (context) => const FAQScreen(),
    settingScreen: (context) => const SettingScreen(),
    search: (context) => const SearchInitScreen(),
    searchResult: (context) => const SearchResultScreen(),
    appliedScreen: (context) => const AppliedScreen(),
    chatListScreen: (context) => const ChatListScreen(),
    chatScreen: (context) => const ChatScreen(),
    jobDetailsScreen: (context) => const JobDetailsScreen(),
    chatScreen: (context) => const ChatScreen(),
  };
}
