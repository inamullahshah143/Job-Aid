// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_aid/constants/colors.dart';
import 'package:job_aid/main.dart';
import 'package:job_aid/screens/chat/get_messages.dart';
import 'package:uuid/uuid.dart';

class ChatRoom extends StatefulWidget {
  final String userId;
  final String username;
  final String phoneNo;
  final String profilePicture;

  const ChatRoom({
    super.key,
    required this.userId,
    required this.username,
    required this.phoneNo,
    required this.profilePicture,
  });

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  final TextEditingController _message = TextEditingController();
  String? messageBody;

  genrateList() async {
    await FirebaseFirestore.instance
        .collection('chat_list')
        .where(
          'chat_room_id',
          isEqualTo: chatRoomId(
            widget.username,
            jsonDecode(prefs!.getString('userDetails')!)['company_name'] ??
                jsonDecode(prefs!.getString('userDetails')!)['name'],
          ),
        )
        .get()
        .then((value) async {
      if (value.docs.isEmpty) {
        await FirebaseFirestore.instance.collection('chat_list').doc().set({
          'user_id': widget.userId,
          'chat_room_id': chatRoomId(
            widget.username,
            jsonDecode(prefs!.getString('userDetails')!)['company_name'] ??
                jsonDecode(prefs!.getString('userDetails')!)['name'],
          ),
          'phone_no': widget.phoneNo,
          'company_id': user.uid,
        });
      }
    });
  }

  void handleSendPressed(String message, String type) async {
    genrateList();
    await FirebaseFirestore.instance
        .collection('chat_room')
        .doc(
          chatRoomId(
            widget.username,
            jsonDecode(prefs!.getString('userDetails')!)['company_name'] ??
                jsonDecode(prefs!.getString('userDetails')!)['name'],
          ),
        )
        .collection('chat')
        .add(
      {
        "author": {
          "name":
              jsonDecode(prefs!.getString('userDetails')!)['company_name'] ??
                  jsonDecode(prefs!.getString('userDetails')!)['name'],
          "id": user.uid,
        },
        "createdAt": DateTime.now().millisecondsSinceEpoch,
        "id": const Uuid().v4(),
        "text": message,
        "type": type,
      },
    );
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
        actions: [
          IconButton(
            padding: EdgeInsets.zero,
            onPressed: () async {},
            icon: Icon(
              Icons.call_outlined,
              size: 18,
            ),
          ),
        ],
        title: ListTile(
          dense: true,
          contentPadding: EdgeInsets.zero,
          leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              image: DecorationImage(
                image: NetworkImage(
                  widget.profilePicture,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Text(
            widget.username,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Text(
            widget.phoneNo,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w200,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          reverse: true,
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: GetMessages(
              chatRoomId: chatRoomId(
                widget.username,
                jsonDecode(prefs!.getString('userDetails')!)['company_name'] ??
                    jsonDecode(prefs!.getString('userDetails')!)['name'],
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Flexible(
              fit: FlexFit.tight,
              child: TextField(
                controller: _message,
                keyboardType: TextInputType.text,
                minLines: 1,
                maxLines: 5,
                decoration: InputDecoration(
                  isDense: true,
                  hintText: 'Type your message',
                  fillColor: AppColor.placeholder.withOpacity(0.2),
                  filled: true,
                  suffixIcon: IconButton(
                    onPressed: () {
                      handleSendPressed(_message.text, 'text');
                      _message.clear();
                    },
                    icon: Icon(
                      Icons.send,
                      color: AppColor.primaryColor,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String chatRoomId(String user, String company) {
    if (user[0].toLowerCase().codeUnits[0] >
        company.toLowerCase().codeUnits[0]) {
      return "${user.replaceAll(' ', '_')}_${company.replaceAll(' ', '_')}";
    } else {
      return "${company.replaceAll(' ', '_')}_${user.replaceAll(' ', '_')}";
    }
  }
}
