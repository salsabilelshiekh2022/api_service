import 'package:elmohtaref/core/extensions/translation_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/components/widgets/custom_multi_lines_text_field_widget.dart';
import '../../../../../generated/app_assets.dart';
import '../../cubit/tech_support_cubit.dart';

class ReportProblemBottomSheet extends StatefulWidget {
  const ReportProblemBottomSheet({super.key, required this.id});
  final int id;

  @override
  State<ReportProblemBottomSheet> createState() =>
      _ReportProblemBottomSheetState();
}

class _ReportProblemBottomSheetState extends State<ReportProblemBottomSheet> {
  late TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.only(left: 16, right: 16, bottom: 32, top: 16),
      color: Colors.grey.shade100,
      // height: 94.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: CustomMultiLinesTextFieldWidget(
              controller: controller,
              hint: context.writeMessageHere,
              minLines: 1,
              maxLines: 5,
            ),
          ),
          SizedBox(width: 16.w),
          InkWell(
            onTap: () {
              if (controller.text.isNotEmpty) {
                context.read<TechSupportCubit>().addMessageForTicket(
                      message: controller.text.trim(),
                      id: widget.id,
                    );
                controller.clear();
              } else {}
            },
            child: Image.asset(
              AppAssets.iconsSend,
              width: 35.w,
              height: 35.h,
            ),
          ),
        ],
      ),
    );
  }
}
