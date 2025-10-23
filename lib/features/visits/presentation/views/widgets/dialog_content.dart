import 'package:elmohtaref/core/extensions/translation_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_text_style.dart';
import 'comment_text_field.dart';
import 'star_rating_widget.dart';

class DialogContent extends StatelessWidget {
  const DialogContent({
    super.key,
    required this.selectedRating,
    required this.onRatingChanged,
    required this.commentController,
  });

  final int selectedRating;
  final Function(int) onRatingChanged;
  final TextEditingController commentController;

  @override
  Widget build(BuildContext context) {
    final AppTextStyles appTextStyle =
        Theme.of(context).extension<AppTextStyles>()!;
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'كيف كانت تجربة الخدمة',
            style: appTextStyle.font18BoldPrimaryColor,
          ),
          8.verticalSpace,
          Text(
            'شارك التجربة حتى نقوم بتطوير الخدمة باستمرار',
            style: appTextStyle.font14RegularPrimaryColor,
          ),
          24.verticalSpace,
          StarRatingWidget(
            selectedRating: selectedRating,
            onRatingChanged: onRatingChanged,
          ),
          24.verticalSpace,
          CommentTextField(
            hint: context.enterComment,
            controller: commentController,
          ),
        ],
      ),
    );
  }
}
