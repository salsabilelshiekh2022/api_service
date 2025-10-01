import 'package:elmohtaref/core/components/widgets/app_snack_bar.dart';
import 'package:elmohtaref/core/extensions/app_extention.dart';
import 'package:elmohtaref/core/extensions/translation_extensions.dart';
import 'package:elmohtaref/features/book_service/presentaion/views/widgets/success_booking_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/components/widgets/main_button.dart';
import '../../cubit/book_service_cubit.dart';

class ComfirmBookServiceButton extends StatelessWidget {
  const ComfirmBookServiceButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<BookServiceCubit, BookServiceState>(
      listener: (context, state) {
        if (state.isFailure) {
          AppSnackBar.showSnackBar(
              context: context,
              message: state.failure!.message,
              state: SnackBarStates.error);
        } else if (state.isSuccess) {
          context.pop();
          SuccessBookingDialog.show(context);
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 30.0, right: 30, bottom: 30.0),
        child: MainButton(
            title: context.bookServiceNow,
            onTap: () {
              context.read<BookServiceCubit>().bookService(context: context);
            }),
      ),
    );
  }
}
