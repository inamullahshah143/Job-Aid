import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:get/get.dart';
import 'package:job_aid/constants/colors.dart';
import 'package:job_aid/constants/components.dart';
import 'package:job_aid/screens/company_home/sub_screens/update_job_post_form.dart';

class CompnayHomeComponents {
  Widget jobPostCard({
    required Function refresh,
    required jobDetails,
    required String postId,
    required String jobTitle,
    required String jobDescription,
    required String maximumSalary,
    required String minimumSalary,
    required String employmentType,
    required String jobType,
    required BuildContext context,
  }) {
    final isPublish = jobDetails['publish_status'] == 1 ? false : true;
    return MaterialButton(
      padding: EdgeInsets.all(5.0),
      onPressed: () {},
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
                trailing: IconButton(
                  icon: Icon(
                    FontAwesome.edit,
                    size: 20,
                    color: AppColor.primaryColor,
                  ),
                  onPressed: () {
                    Get.to(UpdateJobPostForm(
                      data: jobDetails,
                      postId: postId,
                      refresh: refresh,
                    ));
                  },
                ),
                contentPadding: EdgeInsets.zero,
                title: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Text(
                    jobTitle,
                    maxLines: 2,
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
                    jobDescription,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColor.placeholder,
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ),
              RichText(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                  style: TextStyle(
                    color: AppColor.blackColor,
                    fontSize: 16.0,
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
              ),
              Divider(
                thickness: 1,
                color: AppColor.placeholder,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Flexible(
                    flex: 1,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            isPublish ? Colors.blue : Colors.orange),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(AppColor.white),
                        overlayColor: MaterialStateProperty.all<Color>(
                            AppColor.primary.withOpacity(0.1)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      onPressed: () async {
                        Components.showAlertDialog(context);
                        if (jobDetails['publish_status'] == 0) {
                          await FirebaseFirestore.instance
                              .collection('jobs')
                              .doc(postId)
                              .update({'publish_status': 1}).whenComplete(() {
                            refresh;
                            Navigator.pop(context, true);
                          });
                        } else {
                          await FirebaseFirestore.instance
                              .collection('jobs')
                              .doc(postId)
                              .update({'publish_status': 0}).whenComplete(() {
                            refresh;
                            Navigator.pop(context, true);
                          });
                        }
                      },
                      child: Text(isPublish ? "Publish" : 'Un Publish'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    flex: 1,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.red),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(AppColor.white),
                        overlayColor: MaterialStateProperty.all<Color>(
                            AppColor.primary.withOpacity(0.1)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      onPressed: () async {
                        await FirebaseFirestore.instance
                            .collection('jobs')
                            .doc(postId)
                            .delete()
                            .whenComplete(() {
                          refresh;
                        });
                      },
                      child: const Text("Delete"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
