import 'package:elmohtaref/core/utils/user_cache_service.dart';
import 'package:elmohtaref/features/book_service/presentaion/cubit/book_service_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'photo_section.dart';
import 'problem_Section.dart';
import 'profile_section.dart';
import 'select_date_section.dart';
import 'service_details_section.dart';

class ServiceBookForm extends StatefulWidget {
  const ServiceBookForm({super.key, required this.serviceId});
  final int serviceId;

  @override
  State<ServiceBookForm> createState() => _ServiceBookFormState();
}

class _ServiceBookFormState extends State<ServiceBookForm> {
  @override
  void initState() {
    context
        .read<BookServiceCubit>()
        .getTimeAvalibilty(serviceId: widget.serviceId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        child: Column(
          children: [
            UserCacheService().currentUser == null
                ? ProfileSection()
                : SizedBox(),
            UserCacheService().currentUser == null
                ? 8.verticalSpace
                : SizedBox(),
            ServiceDetailsSection(),
            8.verticalSpace,
            SelectDateSection(),
            8.verticalSpace,
            ProblemSection(),
            8.verticalSpace,
            PhotoSection(),
            80.verticalSpace,
          ],
        ),
      ),
    );
  }
}
