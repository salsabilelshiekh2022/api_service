import 'dart:async';

import 'package:elmohtaref/core/extensions/translation_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/components/widgets/app_snack_bar.dart';
import '../../../../../core/theme/app_text_style.dart';
import '../../cubit/tech_support_cubit.dart';
import '../../cubit/tech_support_state.dart';
import 'messages_list.dart';
import 'report_problem_bottom_sheet.dart';

class ReportProblemBody extends StatefulWidget {
  const ReportProblemBody({super.key, required this.id});
  final int id;

  @override
  State<ReportProblemBody> createState() => _ReportProblemBodyState();
}

class _ReportProblemBodyState extends State<ReportProblemBody> {
  Timer? timer;
  Future<void> callMehtod() async {
    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      context.read<TechSupportCubit>().showTicket(id: widget.id);
    });
  }

  @override
  void initState() {
    context.read<TechSupportCubit>().state.messages = [];
    context.read<TechSupportCubit>().showTicket(id: widget.id);

    callMehtod();
    super.initState();
  }

  bool isClosed = false;

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appTextTheme = Theme.of(context).extension<AppTextStyles>()!;
    return BlocConsumer<TechSupportCubit, TechSupportState>(
      listener: (context, state) {
        if (state.isGetMessagesSuccess &&
            state.ticketMessages!.data!.status == "closed" &&
            isClosed == false) {
          isClosed = true;

          AppSnackBar.showSnackBar(
            context: context,
            message: context.closeComplaint,
            state: SnackBarStates.error,
          );

          context.read<TechSupportCubit>().getTicketsList();
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            Text(
              context.leaveYourComplaint,
              style: appTextTheme.font12RegularLabelColor,
            ),
            Expanded(child: MessagesList(messages: state.messages)),
            isClosed
                ? const SizedBox()
                : ReportProblemBottomSheet(id: widget.id),
          ],
        );
      },
    );
  }
}
