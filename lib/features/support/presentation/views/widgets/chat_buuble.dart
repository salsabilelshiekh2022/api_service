import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_style.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({super.key, required this.isMe, required this.message});

  final bool isMe;
  final String message;

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    final appTextStyles = Theme.of(context).extension<AppTextStyles>()!;
    return Container(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      width: MediaQuery.sizeOf(context).width,
      child: IntrinsicWidth(
        child: Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7,
              ),
              decoration: BoxDecoration(
                color: isMe
                    ? appColors.primaryColor
                    : appColors.secondaryColor.withAlpha(20),
                borderRadius: BorderRadiusDirectional.only(
                  topStart: isMe
                      ? const Radius.circular(0)
                      : const Radius.circular(16),
                  topEnd: !isMe
                      ? const Radius.circular(0)
                      : const Radius.circular(16),
                  bottomStart: const Radius.circular(16),
                  bottomEnd: const Radius.circular(16),
                ),
              ),
              child: Text(
                message,
                style: appTextStyles.font14RegularSecondaryColor.copyWith(
                  color: isMe ? Colors.white : appColors.primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
