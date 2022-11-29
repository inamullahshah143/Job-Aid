import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:job_aid/constants/colors.dart';
import 'package:job_aid/main.dart';

class GetMessages extends StatelessWidget {
  GetMessages({
    super.key,
    required this.chatRoomId,
  });

  final String chatRoomId;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  getSenderView(
    BuildContext context,
    String message,
    String type,
    String messageId,
  ) =>
      GestureDetector(
        onLongPress: () {
          copyToClipboard(context, message);
        },
        child: BubbleSpecialThree(
          text: message,
          color: AppColor.appThemeColor,
          isSender: true,
          tail: false,
          textStyle: TextStyle(color: Colors.white, fontSize: 16),
        ),
      );

  getReceiverView(BuildContext context, String message, String type) =>
      GestureDetector(
        onLongPress: () {
          copyToClipboard(context, message);
        },
        child: BubbleSpecialThree(
          text: message,
          color: AppColor.blackColor,
          isSender: false,
          tail: false,
          textStyle: TextStyle(color: Colors.white, fontSize: 16),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('chat_room')
            .doc(chatRoomId)
            .collection('chat')
            .orderBy("createdAt")
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              shrinkWrap: true,
              primary: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                QueryDocumentSnapshot queryDocumentSnapshot =
                    snapshot.data!.docs[index];
                return queryDocumentSnapshot['author']['id'] != user.uid
                    ? getReceiverView(context, queryDocumentSnapshot['text'],
                        queryDocumentSnapshot['type'])
                    : getSenderView(
                        context,
                        queryDocumentSnapshot['text'],
                        queryDocumentSnapshot['type'],
                        queryDocumentSnapshot['id'],
                      );
              },
            ),
          );
        },
      ),
    );
  }

  Future<void> copyToClipboard(context, text) async {
    await Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Copied to clipboard'),
    ));
  }
}
