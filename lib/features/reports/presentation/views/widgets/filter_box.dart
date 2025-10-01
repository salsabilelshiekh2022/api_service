import 'package:elmohtaref/features/book_service/data/repos/book_service_repo.dart';
import 'package:elmohtaref/features/book_service/presentaion/cubit/book_service_cubit.dart';
import 'package:elmohtaref/features/home/home/presentation/cubit/home_cubit.dart';
import 'package:elmohtaref/features/visits/cubit/visits_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/di/dependency_injection.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../home/home/data/repos/home_repo.dart';
import '../../cubit/reports_cubit.dart';
import 'filter_dialog.dart';

class FilterBox extends StatelessWidget {
  const FilterBox({super.key, this.isFromReports = true});
  final bool isFromReports;

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    return InkWell(
      onTap: () async {
        showDialog<void>(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext dialogContext) => MultiBlocProvider(
            providers: [
              isFromReports
                  ? BlocProvider.value(value: context.read<ReportsCubit>())
                  : BlocProvider.value(value: context.read<VisitsCubit>()),
              BlocProvider<HomeCubit>(
                create: (context) => HomeCubit(getIt<HomeRepo>()),
              ),
              BlocProvider<BookServiceCubit>(
                create: (context) => BookServiceCubit(getIt<BookServiceRepo>()),
              ),
            ],
            child: FilterDialog(isFromReports: isFromReports),
          ),
        );
      },
      child: Container(
        height: 42.h,
        width: 42.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Icon(
          Icons.filter_list,
          color: appColors.primaryColor,
        ),
      ),
    );
  }
}
