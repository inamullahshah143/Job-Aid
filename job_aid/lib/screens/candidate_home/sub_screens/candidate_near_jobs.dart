import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:job_aid/screens/candidate_home/sub_screens/job_details.dart';

class CandidateNearJobs extends StatefulWidget {
  CandidateNearJobs({super.key});

  @override
  State<CandidateNearJobs> createState() => _CandidateNearJobsState();
}

class _CandidateNearJobsState extends State<CandidateNearJobs> {
  Completer<GoogleMapController> _controller = Completer();
  CameraPosition? _kGooglePlex;
  Set<Marker> markers = <Marker>{};
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getNearByJob().whenComplete(() {
        setState(() {});
        setState(() {});
        setState(() {});
      });
    });
    _kGooglePlex = CameraPosition(
      target: LatLng(33.7367652, 72.817363),
      zoom: 10,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        markers: markers,
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        mapType: MapType.terrain,
        initialCameraPosition: _kGooglePlex!,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }

  Future getNearByJob() async {
    await FirebaseFirestore.instance
        .collection('jobs')
        .get()
        .then((jobs) async {
      for (var job in jobs.docs) {
        await FirebaseFirestore.instance
            .collection('compnay_record')
            .doc(job.data()['posted_by'])
            .get()
            .then((company) {
          markers.add(
            Marker(
              markerId: MarkerId(company.data()!['company_name']),
              position: LatLng(
                  company.data()!['latitude'], company.data()!['longitude']),
              infoWindow: InfoWindow(
                title: job.data()['job_title'],
                onTap: () {
                  Get.to(
                    JobDetails(
                      jobTitle: job.data()['job_title'],
                      companyName: company.data()!['company_name'],
                      companyLogo: company.data()!['company_logo'],
                      location: company.data()!['complete_address'] +
                          ', ' +
                          company.data()!['city'] +
                          ', ' +
                          company.data()!['province'],
                      maximumSalary: job.data()['maximum_salary'],
                      minimumSalary: job.data()['minimum_salary'],
                      employmentType: job.data()['job_title'],
                      jobType: job.data()['job_type'],
                      jobDetails: job.data(),
                      jobId: job.id,
                    ),
                  );
                },
              ),
            ),
          );
        });
      }
    });
  }
}
