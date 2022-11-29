import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_aid/constants/colors.dart';
import 'package:job_aid/screens/candidate_home/sub_screens/job_details.dart';

class HomeScreenComponents {
  final isSaved = false.obs;
  Widget recommendedJobsCard({
    required Map<String, dynamic> jobDetails,
    required String jobId,
    required String jobTitle,
    required String companyName,
    required String companyLogo,
    required String location,
    required String maximumSalary,
    required String minimumSalary,
    required String employmentType,
    required String jobType,
    required BuildContext context,
  }) {
    return MaterialButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        Get.to(
          JobDetails(
            jobTitle: jobTitle,
            companyName: companyName,
            companyLogo: companyLogo,
            location: location,
            maximumSalary: maximumSalary,
            minimumSalary: minimumSalary,
            employmentType: employmentType,
            jobType: jobType,
            jobDetails: jobDetails,
            jobId: jobId,
          ),
        );
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Card(
          margin: EdgeInsets.zero,
          color: AppColor.placeholderBg,
          elevation: 2,
          shadowColor: AppColor.placeholder.withOpacity(0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColor.white,
                      image: DecorationImage(
                        image: NetworkImage(companyLogo),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  trailing: Obx(() {
                    return IconButton(
                      icon: Icon(
                        isSaved.isTrue
                            ? Icons.bookmark
                            : Icons.bookmark_outline,
                        size: 20,
                        color: AppColor.primaryColor,
                      ),
                      onPressed: () {
                        isSaved.value = !isSaved.value;
                      },
                    );
                  }),
                  contentPadding: EdgeInsets.zero,
                  title: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Text(
                      jobTitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColor.primaryColor,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Text(
                      companyName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColor.blackColor,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                ),
                Divider(
                  thickness: 1,
                  color: AppColor.placeholder,
                ),
                Text(
                  location,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColor.blackColor,
                    fontSize: 14.0,
                  ),
                ),
                SizedBox(height: 5),
                RichText(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    style: TextStyle(
                      color: AppColor.placeholder,
                      fontSize: 12.0,
                    ),
                    children: [
                      TextSpan(text: 'PKR '),
                      TextSpan(
                        text: minimumSalary,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(text: ' - PKR '),
                      TextSpan(
                        text: maximumSalary,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    children: [
                      Card(
                        margin: EdgeInsets.zero,
                        color: AppColor.transparent,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(
                              color: AppColor.primaryColor.withOpacity(0.5)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            employmentType,
                            style: TextStyle(
                              color: AppColor.primaryColor,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Card(
                        margin: EdgeInsets.zero,
                        color: AppColor.transparent,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(
                              color: AppColor.primaryColor.withOpacity(0.5)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            jobType,
                            style: TextStyle(
                              color: AppColor.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget recentJobsCard({
    required Map<String, dynamic> jobDetails,
    required String jobId,
    required String jobTitle,
    required String companyName,
    required String companyLogo,
    required String location,
    required String maximumSalary,
    required String minimumSalary,
    required String employmentType,
    required String jobType,
    required BuildContext context,
  }) {
    return MaterialButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        Get.to(
          JobDetails(
            jobTitle: jobTitle,
            companyName: companyName,
            companyLogo: companyLogo,
            location: location,
            maximumSalary: maximumSalary,
            minimumSalary: minimumSalary,
            employmentType: employmentType,
            jobType: jobType,
            jobDetails: jobDetails,
            jobId: jobId,
          ),
        );
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Card(
          margin: EdgeInsets.zero,
          color: AppColor.placeholderBg,
          elevation: 2,
          shadowColor: AppColor.placeholder.withOpacity(0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColor.white,
                      image: DecorationImage(
                        image: NetworkImage(companyLogo),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  trailing: Obx(() {
                    return IconButton(
                      icon: Icon(
                        isSaved.isTrue
                            ? Icons.bookmark
                            : Icons.bookmark_outline,
                        size: 20,
                        color: AppColor.primaryColor,
                      ),
                      onPressed: () {
                        isSaved.value = !isSaved.value;
                      },
                    );
                  }),
                  contentPadding: EdgeInsets.zero,
                  title: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Text(
                      jobTitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColor.primaryColor,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Text(
                      companyName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColor.blackColor,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                ),
                Divider(
                  thickness: 1,
                  color: AppColor.placeholder,
                ),
                Text(
                  location,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColor.blackColor,
                    fontSize: 14.0,
                  ),
                ),
                SizedBox(height: 5),
                RichText(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    style: TextStyle(
                      color: AppColor.placeholder,
                      fontSize: 12.0,
                    ),
                    children: [
                      TextSpan(text: 'PKR '),
                      TextSpan(
                        text: minimumSalary,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(text: ' - PKR '),
                      TextSpan(
                        text: maximumSalary,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    children: [
                      Card(
                        margin: EdgeInsets.zero,
                        color: AppColor.transparent,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(
                              color: AppColor.primaryColor.withOpacity(0.5)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            employmentType,
                            style: TextStyle(
                              color: AppColor.primaryColor,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Card(
                        margin: EdgeInsets.zero,
                        color: AppColor.transparent,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(
                              color: AppColor.primaryColor.withOpacity(0.5)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            jobType,
                            style: TextStyle(
                              color: AppColor.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
