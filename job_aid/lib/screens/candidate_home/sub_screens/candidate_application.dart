import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:job_aid/constants/colors.dart';
import 'package:job_aid/constants/k_images.dart';
import 'package:job_aid/screens/candidate_home/controller/application_controller.dart';

class CandidateApplication extends StatelessWidget {
  const CandidateApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: ApplicationController().getMyApplications(context),
      builder: (context, snapshot) {
        return snapshot.connectionState == ConnectionState.waiting
            ? Padding(
                padding: const EdgeInsets.all(10.0),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : snapshot.hasData && snapshot.data!.length > 0
                ? Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return snapshot.data![index];
                      },
                    ),
                  )
                : Container();
      },
    );
  }
}
