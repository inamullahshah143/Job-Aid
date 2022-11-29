import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_aid/constants/components.dart';
import 'package:job_aid/main.dart';
import 'chat_room.dart';

class ChatController {
  Stream<Widget> getCompanyChat(context) async* {
    List x = <Widget>[];
    await FirebaseFirestore.instance
        .collection('chat_list')
        .where('company_id', isEqualTo: user.uid)
        .get()
        .then((value) async {
      for (var item in value.docs) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(item.data()['user_id'])
            .get()
            .then((user) async {
          await FirebaseFirestore.instance
              .collection('user_record')
              .doc(item.data()['user_id'])
              .get()
              .then((userRecord) {
            x.add(
              ListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                onTap: () {
                  Get.to(
                    ChatRoom(
                      userId: item.data()['user_id'],
                      username: user.data()!['name'],
                      phoneNo: user.data()!['phone_no'],
                      profilePicture: userRecord.data()!['profile_picture'],
                    ),
                  );
                },
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    image: DecorationImage(
                      image: NetworkImage(
                        userRecord.data()!['profile_picture'],
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                title: Text(user.data()!['name']),
                subtitle: Text(user.data()!['phone_no']),
                trailing: IconButton(
                  icon: const Icon(
                    Icons.phone,
                    size: 18,
                  ),
                  onPressed: () async {
                    // Helper().callNumber(context, user.data()['phone_no']);
                  },
                ),
              ),
            );
          });
        });
      }
    });

    yield Padding(
      padding: const EdgeInsets.all(15.0),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: x.length,
        itemBuilder: (context, index) {
          return x[index];
        },
      ),
    );
  }

  Stream<Widget> getUserChat(context) async* {
    List x = <Widget>[];
    await FirebaseFirestore.instance
        .collection('chat_list')
        .where('user_id', isEqualTo: user.uid)
        .get()
        .then((value) async {
      for (var item in value.docs) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(item.data()['company_id'])
            .get()
            .then((userData) async {
          await FirebaseFirestore.instance
              .collection('compnay_record')
              .doc(userData.id)
              .get()
              .then((companyRecord) {
            x.add(
              ListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                onTap: () {
                  Get.to(
                    ChatRoom(
                      userId: companyRecord.id,
                      username: userData.data()!['name'],
                      phoneNo: userData.data()!['phone_no'],
                      profilePicture: companyRecord.data()!['company_logo'],
                    ),
                  );
                },
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    image: DecorationImage(
                      image: NetworkImage(
                        companyRecord.data()!['company_logo'],
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                title: Text(userData.data()!['name']),
                subtitle: Text(userData.data()!['phone_no']),
                trailing: IconButton(
                  icon: const Icon(
                    Icons.phone,
                    size: 18,
                  ),
                  onPressed: () async {
                    // Helper().callNumber(context, user.data()['phone_no']);
                  },
                ),
              ),
            );
          }).catchError((e) {
            Components.showSnackBar(context, e.toString());
          });
        }).catchError((e) {
          Components.showSnackBar(context, e.toString());
        });
      }
    }).catchError((e) {
      Components.showSnackBar(context, e.toString());
    });

    yield Padding(
      padding: const EdgeInsets.all(15.0),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: x.length,
        itemBuilder: (context, index) {
          return x[index];
        },
      ),
    );
  }
}
