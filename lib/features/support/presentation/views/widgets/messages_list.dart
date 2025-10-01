import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/models/ticket_messages_model.dart';
import 'chat_buuble.dart';

class MessagesList extends StatelessWidget {
  const MessagesList({super.key, required this.messages});

  final List<Messages> messages;

  @override
  Widget build(BuildContext context) {
    return messages.isEmpty
        ? const SizedBox()
        : ListView.separated(
            padding: EdgeInsets.only(
              top: 16.h,
              bottom: 110.h,
              left: 16.w,
              right: 16.w,
            ),
            reverse: false,
            itemBuilder: (context, index) {
              return ChatBubble(
                isMe: messages[index].sender == "User" ||
                    messages[index].sender == "Guest",
                message: messages[index].content ?? '',
              );
            },
            separatorBuilder: (_, __) => 16.verticalSpace,
            itemCount: messages.length,
          );
  }
}
