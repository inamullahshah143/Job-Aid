import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:job_aid/constants/colors.dart';

class ProfileComponents {
  Widget workExperienceCard({
    required String jobTitle,
    required String companyName,
    required String from,
    required String to,
  }) {
    return Card(
      margin: EdgeInsets.zero,
      color: AppColor.transparent,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(color: AppColor.primaryColor.withOpacity(0.5)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListTile(
          trailing: IconButton(
            icon: Icon(
              FontAwesome5.edit,
              size: 16,
              color: AppColor.primaryColor,
            ),
            onPressed: () {},
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  companyName,
                  style: TextStyle(
                    color: AppColor.blackColor,
                    fontSize: 14.0,
                  ),
                ),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: AppColor.placeholder,
                      fontSize: 14.0,
                    ),
                    children: [
                      TextSpan(text: 'From: '),
                      TextSpan(
                        text: from,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(text: ', To: '),
                      TextSpan(
                        text: to,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget educationCard({
    required String degreeTitle,
    required String uniName,
    required String from,
    required String to,
    required String score,
  }) {
    return Card(
      margin: EdgeInsets.zero,
      color: AppColor.transparent,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(color: AppColor.primaryColor.withOpacity(0.5)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListTile(
          trailing: IconButton(
            icon: Icon(
              FontAwesome5.edit,
              size: 16,
              color: AppColor.primaryColor,
            ),
            onPressed: () {},
          ),
          contentPadding: EdgeInsets.zero,
          title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Text(
              degreeTitle,
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  uniName,
                  style: TextStyle(
                    color: AppColor.blackColor,
                    fontSize: 14.0,
                  ),
                ),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: AppColor.placeholder,
                      fontSize: 14.0,
                    ),
                    children: [
                      TextSpan(text: 'From: '),
                      TextSpan(
                        text: from,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(text: ', To: '),
                      TextSpan(
                        text: to,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: AppColor.placeholder,
                      fontSize: 14.0,
                    ),
                    children: [
                      TextSpan(text: 'Score: '),
                      TextSpan(
                        text: score,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget projectsCard({
    required String projectTitle,
    required String role,
    required String from,
    required String to,
    required String url,
  }) {
    return Card(
      margin: EdgeInsets.zero,
      color: AppColor.transparent,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(color: AppColor.primaryColor.withOpacity(0.5)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListTile(
          trailing: IconButton(
            icon: Icon(
              FontAwesome5.edit,
              size: 16,
              color: AppColor.primaryColor,
            ),
            onPressed: () {},
          ),
          contentPadding: EdgeInsets.zero,
          title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Text(
              projectTitle,
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  role,
                  style: TextStyle(
                    color: AppColor.blackColor,
                    fontSize: 14.0,
                  ),
                ),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: AppColor.placeholder,
                      fontSize: 14.0,
                    ),
                    children: [
                      TextSpan(text: 'From: '),
                      TextSpan(
                        text: from,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(text: ', To: '),
                      TextSpan(
                        text: to,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                MaterialButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {},
                  child: Text(
                    'Show Project',
                    style: TextStyle(
                      color: AppColor.primaryColor,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget certificateCard({
    required String certificateTitle,
    required String companyName,
    required String from,
  }) {
    return Card(
      margin: EdgeInsets.zero,
      color: AppColor.transparent,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(color: AppColor.primaryColor.withOpacity(0.5)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListTile(
          trailing: IconButton(
            icon: Icon(
              FontAwesome5.edit,
              size: 16,
              color: AppColor.primaryColor,
            ),
            onPressed: () {},
          ),
          contentPadding: EdgeInsets.zero,
          title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Text(
              certificateTitle,
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  companyName,
                  style: TextStyle(
                    color: AppColor.blackColor,
                    fontSize: 14.0,
                  ),
                ),
                Text(
                  from,
                  style: TextStyle(
                    color: AppColor.placeholder,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget languageCard({
    required String languageTitle,
    required String proficiency,
  }) {
    return Card(
      margin: EdgeInsets.zero,
      color: AppColor.transparent,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(color: AppColor.primaryColor.withOpacity(0.5)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListTile(
          trailing: IconButton(
            icon: Icon(
              FontAwesome5.edit,
              size: 16,
              color: AppColor.primaryColor,
            ),
            onPressed: () {},
          ),
          contentPadding: EdgeInsets.zero,
          title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Text(
              languageTitle,
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
              proficiency,
              style: TextStyle(
                color: AppColor.blackColor,
                fontSize: 14.0,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget workExperienceDetailCard({
    required String jobTitle,
    required String companyName,
    required String from,
    required String to,
  }) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListTile(
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                companyName,
                style: TextStyle(
                  color: AppColor.blackColor,
                  fontSize: 14.0,
                ),
              ),
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    color: AppColor.placeholder,
                    fontSize: 14.0,
                  ),
                  children: [
                    TextSpan(text: 'From: '),
                    TextSpan(
                      text: from,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(text: ', To: '),
                    TextSpan(
                      text: to,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget educationDetailCard({
    required String degreeTitle,
    required String uniName,
    required String from,
    required String to,
    required String score,
  }) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Text(
            degreeTitle,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                uniName,
                style: TextStyle(
                  color: AppColor.blackColor,
                  fontSize: 14.0,
                ),
              ),
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    color: AppColor.placeholder,
                    fontSize: 14.0,
                  ),
                  children: [
                    TextSpan(text: 'From: '),
                    TextSpan(
                      text: from,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(text: ', To: '),
                    TextSpan(
                      text: to,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    color: AppColor.placeholder,
                    fontSize: 14.0,
                  ),
                  children: [
                    TextSpan(text: 'Score: '),
                    TextSpan(
                      text: score,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget projectsDetailsCard({
    required String projectTitle,
    required String role,
    required String from,
    required String to,
    required String url,
  }) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Text(
            projectTitle,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                role,
                style: TextStyle(
                  color: AppColor.blackColor,
                  fontSize: 14.0,
                ),
              ),
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    color: AppColor.placeholder,
                    fontSize: 14.0,
                  ),
                  children: [
                    TextSpan(text: 'From: '),
                    TextSpan(
                      text: from,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(text: ', To: '),
                    TextSpan(
                      text: to,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              MaterialButton(
                padding: EdgeInsets.zero,
                onPressed: () {},
                child: Text(
                  'Show Project',
                  style: TextStyle(
                    color: AppColor.primaryColor,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget certificateDetailCard({
    required String certificateTitle,
    required String companyName,
    required String from,
  }) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Text(
            certificateTitle,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                companyName,
                style: TextStyle(
                  color: AppColor.blackColor,
                  fontSize: 14.0,
                ),
              ),
              Text(
                from,
                style: TextStyle(
                  color: AppColor.placeholder,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget languageDetailCard({
    required String languageTitle,
    required String proficiency,
  }) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Text(
            languageTitle,
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
            proficiency,
            style: TextStyle(
              color: AppColor.blackColor,
              fontSize: 14.0,
            ),
          ),
        ),
      ),
    );
  }
}
