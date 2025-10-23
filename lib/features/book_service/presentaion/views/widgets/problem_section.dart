import 'package:elmohtaref/core/extensions/translation_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_text_style.dart';
import '../../cubit/book_service_cubit.dart';

class ProblemSection extends StatelessWidget {
  const ProblemSection({super.key});

  @override
  Widget build(BuildContext context) {
    final appTextStyles = Theme.of(context).extension<AppTextStyles>()!;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(context.notes, style: appTextStyles.font14RegularPrimaryColor),
          8.verticalSpace,
          Container(
            width: double.infinity,
            height: 90.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: TextFormField(
              controller: context.read<BookServiceCubit>().notesController,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 14,
              ),
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                hintText: context.enterNotes,
                hintStyle: appTextStyles.font14RegularSecondaryColor,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.all(14),
              ),
            ),
          )
          // CommentTextField(
          //   controller: context.read<BookServiceCubit>().notesController,
          //   hint: context.enterNotes,
          // ),
        ],
      ),
    );
  }
}
