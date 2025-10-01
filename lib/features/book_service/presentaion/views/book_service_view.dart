import 'package:elmohtaref/core/components/widgets/custom_modal_hub.dart';
import 'package:elmohtaref/features/book_service/presentaion/cubit/book_service_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/components/widgets/custom_app_bar.dart';
import 'widgets/comfirm_book_service_button.dart';
import 'widgets/service_book_form.dart';

class BookServiceView extends StatefulWidget {
  const BookServiceView(
      {super.key, required this.title, required this.serciveId});
  final String title;
  final int serciveId;

  @override
  State<BookServiceView> createState() => _BookServiceViewState();
}

class _BookServiceViewState extends State<BookServiceView> {
  @override
  void initState() {
    context.read<BookServiceCubit>().serviceId = widget.serciveId;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookServiceCubit, BookServiceState>(
      builder: (context, state) {
        return CustomModelProgressIndecator(
          inAsyncCall: state.isLoading,
          child: Scaffold(
            bottomSheet: ComfirmBookServiceButton(),
            body: GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CustomAppBar(
                      title: widget.title,
                      isBack: true,
                    ),
                    ServiceBookForm(
                      serviceId: widget.serciveId,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
