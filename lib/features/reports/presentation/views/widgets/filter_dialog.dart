import 'package:elmohtaref/core/components/widgets/main_button.dart';
import 'package:elmohtaref/core/extensions/app_extention.dart';
import 'package:elmohtaref/core/extensions/translation_extensions.dart';
import 'package:elmohtaref/features/book_service/presentaion/cubit/book_service_cubit.dart';
import 'package:elmohtaref/features/home/home/presentation/cubit/home_cubit.dart';
import 'package:elmohtaref/features/visits/cubit/visits_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/reports_cubit.dart';
import 'filter_dialog_content.dart';
import 'filter_dialog_header.dart';

class FilterDialog extends StatefulWidget {
  const FilterDialog({super.key, required this.isFromReports});
  final bool isFromReports;

  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  @override
  void initState() {
    context.read<HomeCubit>().getHomeServices();
    context.read<BookServiceCubit>().getCarTypes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      clipBehavior: Clip.none,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24.0),
      backgroundColor: Colors.transparent,
      child: Container(
        width: context.width * 0.9,
        constraints: BoxConstraints(
          maxHeight: context.height * 0.9,
        ),
        margin: const EdgeInsets.symmetric(
          vertical: 0,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const FilterDialogHeader(),
            Flexible(
              child: SingleChildScrollView(
                child: FilterDialogContent(
                  isFromReports: widget.isFromReports,
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
              child: MainButton(
                  title: context.save,
                  onTap: () {
                    widget.isFromReports
                        ? context.read<ReportsCubit>().fetchReports()
                        : context.read<VisitsCubit>().fetchVisits();
                    Navigator.of(context).pop({});
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
