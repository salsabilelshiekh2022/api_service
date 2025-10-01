import 'package:elmohtaref/core/extensions/translation_extensions.dart';
import 'package:elmohtaref/features/book_service/presentaion/cubit/book_service_cubit.dart';
import 'package:elmohtaref/features/reports/presentation/cubit/reports_cubit.dart';
import 'package:elmohtaref/features/visits/cubit/visits_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../core/components/widgets/custom_drop_down.dart';
import 'section_title.dart';

class CarBrandSection extends StatefulWidget {
  const CarBrandSection({super.key, required this.isFromReports});
  final bool isFromReports;

  @override
  State<CarBrandSection> createState() => _CarBrandSectionState();
}

class _CarBrandSectionState extends State<CarBrandSection> {
  String? selectedCarBrand;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookServiceCubit, BookServiceState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SectionTitle(title: context.carBrand),
            12.verticalSpace,
            Skeletonizer(
              enabled: state.isGetCarTypesLoading,
              child: CustomDropdown(
                title: context.carBrand,
                hint: context.all,
                items: state.carTypesResponse != null
                    ? state.carTypesResponse!.data
                        .map((e) => DropdownMenuItem(
                              value: e.name.toString(),
                              child: Text(e.name),
                            ))
                        .toList()
                    : [],
                selectedValue: selectedCarBrand,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      selectedCarBrand = newValue;
                      widget.isFromReports
                          ? context.read<ReportsCubit>().state.carModelId =
                              state.carTypesResponse!.data
                                  .firstWhere((car) => car.name == newValue)
                                  .id
                          : context.read<VisitsCubit>().state.carTypeId = state
                              .carModelsResponse!.data
                              .firstWhere((car) => car.name == newValue)
                              .id;
                    });
                  }
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
