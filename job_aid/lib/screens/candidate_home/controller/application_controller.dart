import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:job_aid/main.dart';

import '../components/application_screen_components.dart';

class ApplicationController {
  Stream<List<Widget>> getMyApplications(context) async* {
    List<Widget> x = [];
    await FirebaseFirestore.instance
        .collection('job_application')
        .where('user_id', isEqualTo: user.uid)
        .get()
        .then((value) async {
      for (var item in value.docs) {
        await FirebaseFirestore.instance
            .collection('compnay_record')
            .doc(item.data()['posted_by'])
            .get()
            .then((companyData) async {
          await FirebaseFirestore.instance
              .collection('jobs')
              .doc(item.data()['job_id'])
              .get()
              .then((jobData) {
            x.add(
              ApplicationsScreenComponents().applicationsCard(
                jobTitle: jobData.data()!['job_title'],
                companyName: companyData.data()!['company_name'],
                companyLogo: companyData.data()!['company_logo'],
                applicationsStatus: item.data()['status'] ?? "",
                context: context,
              ),
            );
          });
        });
      }
    });
    yield x;
  }
}
