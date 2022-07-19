import 'package:flutter/material.dart';
import 'package:job_finding/screens/home/component/home_job_card_component.dart';

class JobAppliedComponent extends StatelessWidget {
  const JobAppliedComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "Job You Applied",
            style: TextStyle(
                fontSize: 20, height: 1.5, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          HomeJobCardComponent(),
          HomeJobCardComponent(),
          HomeJobCardComponent(),
        ],
      ),
    );
  }
}
