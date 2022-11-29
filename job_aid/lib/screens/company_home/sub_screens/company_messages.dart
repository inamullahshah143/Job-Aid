import 'package:flutter/material.dart';
import 'package:job_aid/screens/chat/chat_controller.dart';

class CompanyMessages extends StatelessWidget {
  const CompanyMessages({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: ChatController().getCompanyChat(context),
      builder: (context, snapshot) {
        return snapshot.connectionState == ConnectionState.waiting
            ? Padding(
                padding: const EdgeInsets.all(10.0),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : snapshot.hasData
                ? Container(child: snapshot.data)
                : Container();
      },
    );
  }
}
