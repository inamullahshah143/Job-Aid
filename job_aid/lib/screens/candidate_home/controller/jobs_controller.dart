import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:job_aid/main.dart';

import '../components/home_screen_components.dart';

class JobController {
  Stream<List<Widget>> getRecomendedJobs(context) async* {
    List<Widget> x = [];
    await FirebaseFirestore.instance
        .collection('jobs')
        .where('publish_status', isEqualTo: 1)
        .where(
          'job_category',
          isEqualTo: jsonDecode(prefs!.getString('userDetails')!)['industry'],
        )
        .get()
        .then((value) async {
      for (var item in value.docs) {
        await FirebaseFirestore.instance
            .collection('compnay_record')
            .doc(item.data()['posted_by'])
            .get()
            .then((companyData) {
          x.add(
            HomeScreenComponents().recommendedJobsCard(
              jobDetails: item.data(),
              jobId: item.id,
              context: context,
              employmentType: item.data()['employment_type'],
              jobTitle: item.data()['job_title'],
              jobType: item.data()['job_type'],
              maximumSalary: item.data()['maximum_salary'],
              minimumSalary: item.data()['minimum_salary'],
              companyLogo: companyData.data()!['company_logo'],
              companyName: companyData.data()!['company_name'],
              location: companyData.data()!['complete_address'] +
                  ', ' +
                  companyData.data()!['city'] +
                  ', ' +
                  companyData.data()!['province'],
            ),
          );
        });
      }
    });
    yield x;
  }
  Stream<List<Widget>> getRecentJobs(context) async* {
    List<Widget> x = [];
    await FirebaseFirestore.instance
        .collection('jobs')
        // .where('publish_status', isEqualTo: 1)
        .where(
          'job_category',
          isNotEqualTo: jsonDecode(prefs!.getString('userDetails')!)['industry'],
        )
        .get()
        .then((value) async {
      for (var item in value.docs) {
        await FirebaseFirestore.instance
            .collection('compnay_record')
            .doc(item.data()['posted_by'])
            .get()
            .then((companyData) {
          x.add(
            HomeScreenComponents().recentJobsCard(
              jobDetails: item.data(),
              jobId: item.id,
              context: context,
              employmentType: item.data()['employment_type'],
              jobTitle: item.data()['job_title'],
              jobType: item.data()['job_type'],
              maximumSalary: item.data()['maximum_salary'],
              minimumSalary: item.data()['minimum_salary'],
              companyLogo: companyData.data()!['company_logo'],
              companyName: companyData.data()!['company_name'],
              location: companyData.data()!['complete_address'] +
                  ', ' +
                  companyData.data()!['city'] +
                  ', ' +
                  companyData.data()!['province'],
            ),
          );
        });
      }
    });
    yield x;
  }
}
