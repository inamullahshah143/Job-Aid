import 'package:flutter/material.dart';
import 'package:job_aid/constants/colors.dart';

class ApplicationsScreenComponents {
  Widget applicationsCard({
    required String jobTitle,
    required String companyName,
    required String companyLogo,
    required String applicationsStatus,
    required BuildContext context,
  }) {
    return Card(
      margin: EdgeInsets.all(10),
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
    );
  }
}
