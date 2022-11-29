import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_aid/constants/colors.dart';
import 'package:job_aid/screens/company_home/controller/job_application_controller.dart';
import 'package:job_aid/screens/company_home/sub_screens/applicant_details.dart';

class CompnayApplicationComponent {
  Widget applicationsCard({
    required String applicationId,
    required String userId,
    required Map<String, dynamic> userDetails,
    required String email,
    required String name,
    required String profilePicture,
    required String applicationsStatus,
    required BuildContext context,
  }) {
    return MaterialButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        Get.to(
          ApplicantDetails(
            applicationId: applicationId,
            userDetails: userDetails,
            applicationsStatus: applicationsStatus,
            userId: userId,
          ),
        );
      },
      child: Card(
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
                trailing: PopupMenuButton<String>(
                  onSelected: (value) {
                    JobApplicationController()
                        .updateApplicationStatus(applicationId, value, context);
                  },
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        child: Text('Approved'),
                        value: 'Approved',
                      ),
                      PopupMenuItem(
                        child: Text('Rejected'),
                        value: 'Rejected',
                      ),
                      PopupMenuItem(
                        child: Text('Pending'),
                        value: 'Pending',
                      ),
                    ];
                  },
                ),
                leading: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: AppColor.white,
                    image: DecorationImage(
                      image: NetworkImage(profilePicture),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                contentPadding: EdgeInsets.zero,
                title: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Text(
                    name,
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
                    email,
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
              Card(
                margin: EdgeInsets.zero,
                color: applicationsStatus == 'Pending'
                    ? Colors.orange.withOpacity(0.1)
                    : applicationsStatus == 'Approved'
                        ? Colors.green.withOpacity(0.1)
                        : applicationsStatus == 'Rejected'
                            ? Colors.red.withOpacity(0.1)
                            : Colors.blue.withOpacity(0.1),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Application ${applicationsStatus}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: applicationsStatus == 'Pending'
                          ? Colors.orange
                          : applicationsStatus == 'Approved'
                              ? Colors.green
                              : applicationsStatus == 'Rejected'
                                  ? Colors.red
                                  : Colors.blue,
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
