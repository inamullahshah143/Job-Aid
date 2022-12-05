import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chip_tags/flutter_chip_tags.dart';
import 'package:get/get.dart';
import 'package:job_aid/constants/colors.dart';
import 'package:job_aid/constants/components.dart';
import 'package:job_aid/constants/industries_list.dart';
import 'package:job_aid/main.dart';

class UpdateJobPostForm extends StatefulWidget {
  final data;
  final String postId;
  const UpdateJobPostForm({
    super.key,
    required this.data,
    required this.postId,
  });

  @override
  State<UpdateJobPostForm> createState() => _UpdateJobPostFormState();
}

class _UpdateJobPostFormState extends State<UpdateJobPostForm> {
  final _items = <String>[].obs;
  final industries = <DropdownMenuItem>[];
  Map<String, dynamic> jobData = {};
  TextEditingController? jobTitle;
  TextEditingController? jobDescriptions;
  TextEditingController? minimumSalary;
  TextEditingController? maximumSalary;
  TextEditingController? minimumQualifications;
  TextEditingController? perksBenefits;
  TextEditingController? jobDesignation;
  TextEditingController? seatsAvailable;
  TextEditingController? companyWebsite;
  @override
  void initState() {
    jobData = widget.data;
    print(widget.postId);
    _items.value = List<String>.from(widget.data['required_skills'] as List);
    jobTitle = TextEditingController(text: widget.data['job_title']);
    jobDescriptions =
        TextEditingController(text: widget.data['job_descriptions']);
    minimumSalary = TextEditingController(text: widget.data['minimum_salary']);
    maximumSalary = TextEditingController(text: widget.data['maximum_salary']);
    minimumQualifications =
        TextEditingController(text: widget.data['minimum_qualifications']);
    perksBenefits =
        TextEditingController(text: widget.data['perks_&_benefits']);
    jobDesignation =
        TextEditingController(text: widget.data['job_designation']);
    seatsAvailable =
        TextEditingController(text: widget.data['seats_available']);
    companyWebsite =
        TextEditingController(text: widget.data['company_website']);

    readIndustries();
    super.initState();
  }

  void readIndustries() {
    for (var item in IndustriesList.industries) {
      industries.add(
        DropdownMenuItem(
          child: Text(
            item,
          ),
          value: item,
        ),
      );
    }
  }

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
          'Update Job',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: jobTitle,
                  onChanged: (value) {
                    jobData['job_title'] = value;
                  },
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                    color: AppColor.blackColor,
                    fontSize: 14,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColor.placeholder.withOpacity(0.15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.all(12.5),
                    hintText: 'Job Title',
                    hintStyle: TextStyle(
                      color: AppColor.placeholder,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: jobDescriptions,
                  onChanged: (value) {
                    jobData['job_descriptions'] = value;
                  },
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.multiline,
                  maxLines: 10,
                  minLines: 7,
                  style: TextStyle(
                    color: AppColor.blackColor,
                    fontSize: 14,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColor.placeholder.withOpacity(0.15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.all(12.5),
                    hintText: 'Job Descriptions',
                    hintStyle: TextStyle(
                      color: AppColor.placeholder,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: TextFormField(
                        controller: minimumSalary,
                        onChanged: (value) {
                          jobData['minimum_salary'] = value;
                        },
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                          color: AppColor.blackColor,
                          fontSize: 14,
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColor.placeholder.withOpacity(0.15),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.all(12.5),
                          hintText: 'Minimum Salary',
                          hintStyle: TextStyle(
                            color: AppColor.placeholder,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Flexible(
                      flex: 1,
                      child: TextFormField(
                        controller: maximumSalary,
                        onChanged: (value) {
                          jobData['maximum_salary'] = value;
                        },
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                          color: AppColor.blackColor,
                          fontSize: 14,
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColor.placeholder.withOpacity(0.15),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.all(12.5),
                          hintText: 'Maximum Salary',
                          hintStyle: TextStyle(
                            color: AppColor.placeholder,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField(
                  value: widget.data['currency'],
                  onChanged: (value) {
                    jobData['currency'] = value;
                  },
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColor.blackColor,
                  ),
                  items: [
                    DropdownMenuItem(
                      value: 'USD',
                      child: Text('USD'),
                    ),
                    DropdownMenuItem(
                      value: 'PKR',
                      child: Text('PKR'),
                    ),
                  ],
                  isDense: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColor.placeholder.withOpacity(0.15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.all(12.5),
                    hintText: 'Currency',
                    isDense: true,
                    hintStyle: TextStyle(
                      color: AppColor.placeholder,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField(
                  value: widget.data['frequency'],
                  onChanged: (value) {
                    jobData['frequency'] = value;
                  },
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColor.blackColor,
                  ),
                  items: [
                    DropdownMenuItem(
                      value: 'Per Hour',
                      child: Text('Per Hour'),
                    ),
                    DropdownMenuItem(
                      value: 'Per Day',
                      child: Text('Per Day'),
                    ),
                    DropdownMenuItem(
                      value: 'Per Week',
                      child: Text('Per Week'),
                    ),
                    DropdownMenuItem(
                      value: 'Per Month',
                      child: Text('Per Month'),
                    ),
                    DropdownMenuItem(
                      value: 'Quartile',
                      child: Text('Quartile'),
                    ),
                    DropdownMenuItem(
                      value: 'Yearly',
                      child: Text('Yearly'),
                    ),
                  ],
                  isDense: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColor.placeholder.withOpacity(0.15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.all(12.5),
                    hintText: 'Frequency',
                    isDense: true,
                    hintStyle: TextStyle(
                      color: AppColor.placeholder,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: minimumQualifications,
                  onChanged: (value) {
                    jobData['minimum_qualifications'] = value;
                  },
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.multiline,
                  maxLines: 10,
                  minLines: 7,
                  style: TextStyle(
                    color: AppColor.blackColor,
                    fontSize: 14,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColor.placeholder.withOpacity(0.15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.all(12.5),
                    hintText: 'Minimum Qualifications',
                    hintStyle: TextStyle(
                      color: AppColor.placeholder,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: perksBenefits,
                  onChanged: (value) {
                    jobData['perks_&_benefits'] = value;
                  },
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.multiline,
                  maxLines: 10,
                  minLines: 7,
                  style: TextStyle(
                    color: AppColor.blackColor,
                    fontSize: 14,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColor.placeholder.withOpacity(0.15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.all(12.5),
                    hintText: 'Perks & Benefits',
                    hintStyle: TextStyle(
                      color: AppColor.placeholder,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ChipTags(
                  list: _items,
                  chipColor: AppColor.primaryColor,
                  iconColor: Colors.white,
                  textColor: Colors.white,
                  separator: ',',
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColor.placeholder.withOpacity(0.15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.all(12.5),
                    hintText: 'Required Skills',
                    hintStyle: TextStyle(
                      color: AppColor.placeholder,
                      fontSize: 14,
                    ),
                  ),
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: jobDesignation,
                  onChanged: (value) {
                    jobData['job_designation'] = value;
                  },
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                    color: AppColor.blackColor,
                    fontSize: 14,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColor.placeholder.withOpacity(0.15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.all(12.5),
                    hintText: 'Job Designation',
                    hintStyle: TextStyle(
                      color: AppColor.placeholder,
                      fontSize: 14,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                DropdownButtonFormField(
                  value: widget.data['job_category'],
                  onChanged: (value) {
                    jobData['job_category'] = value;
                  },
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColor.blackColor,
                  ),
                  items: industries,
                  isDense: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColor.placeholder.withOpacity(0.15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.all(12.5),
                    hintText: 'Job Category',
                    isDense: true,
                    hintStyle: TextStyle(
                      color: AppColor.placeholder,
                      fontSize: 14,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                DropdownButtonFormField(
                  value: widget.data['education'],
                  onChanged: (value) {
                    jobData['education'] = value;
                  },
                  items: [
                    DropdownMenuItem(
                      child: Text('Primary'),
                      value: 'Primary',
                    ),
                    DropdownMenuItem(
                      child: Text('Lower Secondary'),
                      value: 'Lower Secondary',
                    ),
                    DropdownMenuItem(
                      child: Text('Upper Secondary'),
                      value: 'Upper Secondary',
                    ),
                    DropdownMenuItem(
                      child: Text('Post-secondary'),
                      value: 'Post-secondary',
                    ),
                    DropdownMenuItem(
                      child: Text('Short-cycle'),
                      value: 'Short-cycle',
                    ),
                    DropdownMenuItem(
                      child: Text('Bachelors degree'),
                      value: 'Bachelors degree',
                    ),
                    DropdownMenuItem(
                      child: Text('Masters degree'),
                      value: 'Masters degree',
                    ),
                    DropdownMenuItem(
                      child: Text('Doctoral degree'),
                      value: 'Doctoral degree',
                    ),
                  ],
                  isDense: true,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColor.blackColor,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColor.placeholder.withOpacity(0.15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.all(12.5),
                    hintText: 'Education',
                    isDense: true,
                    hintStyle: TextStyle(
                      color: AppColor.placeholder,
                      fontSize: 14,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                DropdownButtonFormField(
                  value: widget.data['experience'],
                  onChanged: (value) {
                    jobData['experience'] = value;
                  },
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColor.blackColor,
                  ),
                  items: [
                    DropdownMenuItem(
                      child: Text('No Experience'),
                      value: 'No Experience',
                    ),
                    DropdownMenuItem(
                      child: Text('1 Year'),
                      value: '1 Year',
                    ),
                    DropdownMenuItem(
                      child: Text('2 - 3 Year\'s'),
                      value: '2-3 Year\'s',
                    ),
                    DropdownMenuItem(
                      child: Text('3 - 5 Year\'s'),
                      value: '3-5 Year\'s',
                    ),
                    DropdownMenuItem(
                      child: Text('5 - Above Year\'s'),
                      value: '5-Above Year\'s',
                    ),
                  ],
                  isDense: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColor.placeholder.withOpacity(0.15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.all(12.5),
                    hintText: 'Experience',
                    isDense: true,
                    hintStyle: TextStyle(
                      color: AppColor.placeholder,
                      fontSize: 14,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                DropdownButtonFormField(
                  value: widget.data['employment_type'],
                  onChanged: (value) {
                    jobData['employment_type'] = value;
                  },
                  items: [
                    DropdownMenuItem(
                      child: Text('Full-Time'),
                      value: 'Full-Time',
                    ),
                    DropdownMenuItem(
                      child: Text('Part-Time'),
                      value: 'Part-Time',
                    ),
                    DropdownMenuItem(
                      child: Text('Seasonal'),
                      value: 'Seasonal',
                    ),
                    DropdownMenuItem(
                      child: Text('Temporary'),
                      value: 'Temporary',
                    ),
                  ],
                  isDense: true,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColor.blackColor,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColor.placeholder.withOpacity(0.15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.all(12.5),
                    hintText: 'Employment Type',
                    isDense: true,
                    hintStyle: TextStyle(
                      color: AppColor.placeholder,
                      fontSize: 14,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                DropdownButtonFormField(
                  value: widget.data['job_type'],
                  onChanged: (value) {
                    jobData['job_type'] = value;
                  },
                  items: [
                    DropdownMenuItem(
                      child: Text('On-Site'),
                      value: 'On-Site',
                    ),
                    DropdownMenuItem(
                      child: Text('Remote'),
                      value: 'Remote',
                    ),
                  ],
                  isDense: true,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColor.blackColor,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColor.placeholder.withOpacity(0.15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.all(12.5),
                    hintText: 'Job Type',
                    isDense: true,
                    hintStyle: TextStyle(
                      color: AppColor.placeholder,
                      fontSize: 14,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: seatsAvailable,
                  onChanged: (value) {
                    jobData['seats_available'] = value;
                  },
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    color: AppColor.blackColor,
                    fontSize: 14,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColor.placeholder.withOpacity(0.15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.all(12.5),
                    hintText: 'Seats Available',
                    hintStyle: TextStyle(
                      color: AppColor.placeholder,
                      fontSize: 14,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: companyWebsite,
                  onChanged: (value) {
                    jobData['company_website'] = value;
                  },
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                    color: AppColor.blackColor,
                    fontSize: 14,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColor.placeholder.withOpacity(0.15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.all(12.5),
                    hintText: 'Company Website',
                    hintStyle: TextStyle(
                      color: AppColor.placeholder,
                      fontSize: 14,
                    ),
                  ),
                ),
                SizedBox(height: 65),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(AppColor.primaryColor),
            foregroundColor: MaterialStateProperty.all<Color>(AppColor.white),
            overlayColor: MaterialStateProperty.all<Color>(
                AppColor.primary.withOpacity(0.1)),
            minimumSize: MaterialStateProperty.all(
              Size(MediaQuery.of(context).size.width, 45),
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          onPressed: () async {
            Components.showAlertDialog(context);
            jobData['required_skills'] = _items;
            jobData['publish_date'] = DateTime.now();
            jobData['publish_status'] = 0;
            jobData['posted_by'] = user.uid;

            await FirebaseFirestore.instance
                .collection('compnay_record')
                .where('user_id', isEqualTo: user.uid)
                .get()
                .then((value) async {
              jobData['compnay_details'] = value.docs.first.data();
            }).whenComplete(() async {
              await FirebaseFirestore.instance
                  .collection('jobs')
                  .doc(widget.postId)
                  .update(jobData)
                  .then((value) async {
                Navigator.pop(context, true);
                Navigator.pop(context, true);
                Components.showSnackBar(
                    context, 'Your job has been updated successfully');
              }).catchError((e) {
                Navigator.of(context).pop();
                Components.showSnackBar(context, e);
              });
            });
          },
          child: const Text("Update Post"),
        ),
      ),
    );
  }
}
