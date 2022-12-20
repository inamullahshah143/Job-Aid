import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_aid/constants/colors.dart';
import 'package:job_aid/screens/candidate_home/controller/jobs_controller.dart';

class AllApplication extends StatelessWidget {
  final bool isRecomended;
  const AllApplication({super.key, required this.isRecomended});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.transparent,
        foregroundColor: AppColor.blackColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            size: 18,
          ),
        ),
        title: Text(
          'All Applications',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: isRecomended
          ? StreamBuilder(
              stream: JobController().getRecomendedJobs(context),
              builder: (context, snapshot) {
                return snapshot.connectionState == ConnectionState.waiting
                    ? Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : snapshot.hasData && snapshot.data!.length > 0
                        ? ListView.builder(
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: snapshot.data![index],
                              );
                            },
                          )
                        : Container();
              },
            )
          : StreamBuilder(
              stream: JobController().getRecentJobs(context),
              builder: (context, snapshot) {
                return snapshot.connectionState == ConnectionState.waiting
                    ? Container()
                    : snapshot.hasData && snapshot.data!.length > 0
                        ? ListView.builder(
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: snapshot.data![index],
                              );
                            },
                          )
                        : Container();
              },
            ),
    );
  }
}
