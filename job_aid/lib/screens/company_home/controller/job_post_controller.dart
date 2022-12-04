import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:job_aid/main.dart';

import '../components/company_home_components.dart';

class JobPostController {
  Stream<List<Widget>> getPostedJobs(context) async* {
    List<Widget> x = [];
    await FirebaseFirestore.instance
        .collection('jobs')
        .where('posted_by', isEqualTo: user.uid)
        .get()
        .then((value) {
      for (var item in value.docs) {
        print(item.data());
        x.add(
          CompnayHomeComponents().jobPostCard(
            postId: item.id,
            jobDetails: item.data(),
            jobDescription: item.data()['job_descriptions']??'',
            context: context,
            employmentType: item.data()['employment_type']??'',
            jobTitle: item.data()['job_title']??'',
            jobType: item.data()['job_type']??'',
            maximumSalary: item.data()['maximum_salary']??'',
            minimumSalary: item.data()['minimum_salary']??'',
          ),
        );
      }
    });
    yield x;
  }
}
