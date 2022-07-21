import 'package:flutter/material.dart';
import 'package:job_finding/utils/constants.dart';

class CompanyComponent extends StatelessWidget {
  const CompanyComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProfile(),
          const SizedBox(height: 24),
          Container(color: boarderColor, height: 1),
          const SizedBox(height: 24),
          _infoAddress(),
          const SizedBox(height: 24),
          const Text(
            "About Pixency",
            style: TextStyle(
                fontSize: 20, height: 1.5, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          const Text(
            "Dynamically integrate virtual growth strategies through seamless internal or \"organic\" sources. multimedia based markets progressively incubate. ",
            style: TextStyle(fontSize: 14, height: 2, color: paragraphColor),
          ),
          SizedBox(
            height: 162,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 16),
              itemCount: 5,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => Container(
                width: 205,
                margin: const EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                    color: circleColor,
                    borderRadius: BorderRadius.circular(16)),
              ),
            ),
          ),
          Row(
            children: const [
              CircleAvatar(radius: 2),
              SizedBox(width: 4),
              Text(
                "5 available job for this company",
                style: TextStyle(fontWeight: FontWeight.w600, height: 1.5),
              ),
              Spacer(),
              Text(
                "Watch Job",
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.w600,
                    height: 1.5,
                    color: secondaryColor),
              ),
            ],
          )
        ],
      ),
    );
  }

  Row _infoAddress() {
    return Row(
      children: [
        Flexible(
          child: Column(
            children: [
              Row(
                children: const [
                  Icon(Icons.call, size: 14, color: secondaryColor),
                  SizedBox(width: 10),
                  Text(
                    "01782-392382",
                    style: TextStyle(
                        height: 1.5, fontSize: 12, fontWeight: FontWeight.w500),
                  )
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: const [
                  Icon(Icons.message, size: 14, color: secondaryColor),
                  SizedBox(width: 10),
                  Text(
                    "01782-392382",
                    style: TextStyle(
                        height: 1.5, fontSize: 12, fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ],
          ),
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Icon(
                Icons.edit_location_sharp,
                color: secondaryColor,
                size: 14,
              ),
              Text(
                "House 11, Road 04, Block J, Taxila 1219",
                style: TextStyle(
                    fontSize: 12, height: 1.5, fontWeight: FontWeight.w500),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProfile() {
    return Row(
      children: [
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            border: Border.all(color: paragraphColor, width: .2),
            borderRadius: BorderRadius.circular(32),
          ),
        ),
        const SizedBox(width: 24),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Pixency",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                height: 1.5,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              "Design institute",
              style: TextStyle(
                color: paragraphColor,
                height: 1.9,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: const [
                Icon(
                  Icons.star,
                  color: secondaryColor,
                  size: 14,
                ),
                SizedBox(width: 5),
                Text(
                  "5.0",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                SizedBox(width: 12),
                Text(
                  "23 Google reviews",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: secondaryColor),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
