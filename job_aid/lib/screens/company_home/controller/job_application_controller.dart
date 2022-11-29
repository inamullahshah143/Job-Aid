import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:job_aid/constants/components.dart';
import 'package:job_aid/main.dart';

import '../components/company_application_componement.dart';

class JobApplicationController {
  Stream<List<Widget>> getApplications(context) async* {
    List<Widget> x = [];
    await FirebaseFirestore.instance
        .collection('job_application')
        .where('posted_by', isEqualTo: user.uid)
        .get()
        .then((value) async {
      for (var item in value.docs) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(item.data()['user_id'])
            .get()
            .then((userRecord) async {
          await FirebaseFirestore.instance
              .collection('user_record')
              .doc(item.data()['user_id'])
              .get()
              .then((userData) async {
            Map<String, dynamic> userDetails = userRecord.data()!;
            userDetails.addAll(userData.data()!);
            x.add(
              CompnayApplicationComponent().applicationsCard(
                applicationId: item.id,
                userId: item.data()['user_id'],
                userDetails: userDetails,
                email: userRecord.data()!['email'],
                name: userRecord.data()!['name'],
                profilePicture: userData.data()!['profile_picture'],
                applicationsStatus: item.data()['status'],
                context: context,
              ),
            );
          });
        });
      }
    });
    yield x;
  }

  Future updateApplicationStatus(
      String applicationId, String status, BuildContext context) async {
    await FirebaseFirestore.instance
        .collection('job_application')
        .doc(applicationId)
        .update({'status': status}).catchError((e) {
      Components.showSnackBar(context, e.toString());
    });
  }
}
