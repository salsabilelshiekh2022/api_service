import 'package:elmohtaref/core/extensions/app_extention.dart';
import 'package:elmohtaref/core/extensions/translation_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/components/widgets/app_snack_bar.dart';
import '../../../../../core/components/widgets/custom_text_field_with_lable.dart';
import '../../../../../core/components/widgets/main_button.dart'
    show MainButton;
import '../../../../../core/routes/routes.dart';
import '../../cubit/tech_support_cubit.dart';
import '../../cubit/tech_support_state.dart';

class AddTicketBody extends StatefulWidget {
  const AddTicketBody({super.key});

  @override
  State<AddTicketBody> createState() => _AddTicketBodyState();
}

class _AddTicketBodyState extends State<AddTicketBody> {
  late TextEditingController controller;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              24.verticalSpace,
              CustomTextFieldWithLabel(
                label: '${context.addressOfComplaint} *',
                hintText: context.enterAddressOfComplaint,
                controller: controller,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return context.pleaseEnterTheAddressOfComplaint;
                  }
                  return null;
                },
              ),
              64.verticalSpace,
              BlocListener<TechSupportCubit, TechSupportState>(
                listener: (context, state) {
                  if (state.isCreateTicketSuccess) {
                    context.pushReplacementNamed(
                      Routes.reportProblemView,
                      arguments: {
                        'id': state.ticketId,
                        'cubit': context.read<TechSupportCubit>(),
                      },
                    );
                  } else if (state.isCreateTicketFailure) {
                    AppSnackBar.showSnackBar(
                      context: context,
                      message: state.failure!.message,
                      state: SnackBarStates.error,
                    );
                  }
                },
                child: MainButton(
                  title: context.startConversation,
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      context
                          .read<TechSupportCubit>()
                          .createNewTicket(title: controller.text.trim())
                          .then((val) {
                        context.read<TechSupportCubit>().getTicketsList();
                      }, onError: (error, stackTrace) {});
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
