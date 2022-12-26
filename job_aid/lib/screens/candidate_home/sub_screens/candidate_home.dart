import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_aid/constants/colors.dart';
import 'package:job_aid/screens/candidate_home/controller/jobs_controller.dart';
import 'package:job_aid/screens/candidate_home/sub_screens/all_application.dart';

class CandidateHomeScreen extends StatelessWidget {
  const CandidateHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColor.placeholder.withOpacity(0.1),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.all(12.5),
              hintText: 'Search for a job or company',
              hintStyle: TextStyle(
                color: AppColor.placeholder,
                fontSize: 14,
              ),
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StreamBuilder(
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
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15.0),
                                        child: Text(
                                          'Recommendation',
                                          style: TextStyle(
                                            color: AppColor.blackColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      MaterialButton(
                                        padding: EdgeInsets.zero,
                                        onPressed: () {
                                          Get.to(AllApplication(
                                            isRecomended: true,
                                          ));
                                        },
                                        child: Text(
                                          'See All',
                                          style: TextStyle(
                                            color: AppColor.primaryColor,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w200,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 210,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      physics: BouncingScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      itemCount: snapshot.data!.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: snapshot.data![index],
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              )
                            : Container();
                  },
                ),
                StreamBuilder(
                  stream: JobController().getRecentJobs(context),
                  builder: (context, snapshot) {
                    return snapshot.connectionState == ConnectionState.waiting
                        ? Container()
                        : snapshot.hasData && snapshot.data!.length > 0
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15.0),
                                        child: Text(
                                          'Recent Jobs',
                                          style: TextStyle(
                                            color: AppColor.blackColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      MaterialButton(
                                        padding: EdgeInsets.zero,
                                        onPressed: () {
                                          Get.to(AllApplication(
                                            isRecomended: false,
                                          ));
                                        },
                                        child: Text(
                                          'See All',
                                          style: TextStyle(
                                            color: AppColor.primaryColor,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w200,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics: BouncingScrollPhysics(),
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: snapshot.data![index],
                                      );
                                    },
                                  ),
                                ],
                              )
                            : Container();
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
