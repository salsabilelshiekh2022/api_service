import 'package:elmohtaref/core/extensions/translation_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/components/widgets/custom_modal_hub.dart';
import '../../../../core/theme/app_text_style.dart';
import '../cubit/tech_support_cubit.dart';
import '../cubit/tech_support_state.dart';
import 'widgets/add_ticket_body.dart';

class AddTicketView extends StatelessWidget {
  const AddTicketView({super.key});

  @override
  Widget build(BuildContext context) {
    final appTextTheme = Theme.of(context).extension<AppTextStyles>()!;
    return BlocBuilder<TechSupportCubit, TechSupportState>(
      builder: (context, state) {
        return CustomModelProgressIndecator(
          inAsyncCall: state.isCreateTicketLoading,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text(
                context.addComplaint,
                style: appTextTheme.font16BoldPrimaryColor,
              ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              centerTitle: true,
            ),
            body: const AddTicketBody(),
          ),
        );
      },
    );
  }
}
