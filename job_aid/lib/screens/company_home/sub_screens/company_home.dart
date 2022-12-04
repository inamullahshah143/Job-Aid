import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_aid/constants/colors.dart';
import 'package:job_aid/screens/company_home/controller/job_post_controller.dart';
import 'package:job_aid/screens/company_home/sub_screens/job_post_form.dart';

class CompanyHomeScreen extends StatefulWidget {
  const CompanyHomeScreen({super.key});

  @override
  State<CompanyHomeScreen> createState() => _CompanyHomeScreenState();
}

class _CompanyHomeScreenState extends State<CompanyHomeScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: StreamBuilder(
          stream: JobPostController().getPostedJobs(context),
          builder: (context, snapshot) {
            return snapshot.connectionState == ConnectionState.waiting
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : snapshot.hasData
                    ? ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return snapshot.data![index];
                        },
                      )
                    : Center(
                        child: Text(
                          'No Record Found',
                          style: TextStyle(
                            color: AppColor.primaryColor,
                          ),
                        ),
                      );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.blackColor,
        onPressed: () {
          Get.to(JobPostForm());
        },
        child: Icon(Icons.add),
        tooltip: 'Post a Job',
      ),
    );
  }
}
