import 'package:flutter/material.dart';
import 'package:job_aid/screens/company_home/controller/job_application_controller.dart';

class CompnayApplication extends StatelessWidget {
  const CompnayApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
            stream: JobApplicationController().getApplications(context),
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
          ),
    );
  }
}
