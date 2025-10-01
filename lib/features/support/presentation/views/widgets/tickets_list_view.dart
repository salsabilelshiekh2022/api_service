import 'package:elmohtaref/core/extensions/translation_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_text_style.dart';
import 'add_problem_button.dart';
import 'tickets_list.dart';

class TicketsListBody extends StatelessWidget {
  const TicketsListBody({super.key});

  @override
  Widget build(BuildContext context) {
    final appTextTheme = Theme.of(context).extension<AppTextStyles>()!;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            context.youCanAddComplaintOrSuggestion,
            style: appTextTheme.font12RegularSecondaryColor,
          ),
          24.verticalSpace,
          // UserCacheService().currentUser == null
          //     ? ShouldLoginWidget()
          //     :
          const Expanded(child: TicketsList()),
          24.verticalSpace,
          // UserCacheService().currentUser == null
          //     ? const SizedBox()
          //     :
          const AddProblemButton(),
        ],
      ),
    );
  }
}
