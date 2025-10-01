import 'package:elmohtaref/core/extensions/translation_extensions.dart';
import 'package:elmohtaref/features/book_service/data/models/report_type_enum.dart';
import 'package:elmohtaref/features/book_service/presentaion/cubit/book_service_cubit.dart';
import 'package:elmohtaref/features/book_service/presentaion/views/widgets/form_title.dart';
import 'package:elmohtaref/generated/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/components/widgets/custom_drop_down.dart';

class ServiceDetailsSection extends StatefulWidget {
  const ServiceDetailsSection({super.key});

  @override
  State<ServiceDetailsSection> createState() => _ServiceDetailsSectionState();
}

class _ServiceDetailsSectionState extends State<ServiceDetailsSection> {
  String? selectedCarBrand;
  String? selectCarModel;
  String? selectReportType;
  String? selectedYearOfManufacture;

  @override
  void initState() {
    context.read<BookServiceCubit>().getCarTypes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookServiceCubit, BookServiceState>(
      builder: (context, state) {
        var cubit = context.read<BookServiceCubit>();
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormTitle(
                  title: context.carBrand,
                  imagePath: AppAssets.iconsSteeringWheel),
              8.verticalSpace,
              CustomDropdown(
                title: context.carBrand,
                hint: context.carBrand,
                items: state.carTypesResponse != null
                    ? state.carTypesResponse!.data
                        .map((e) => DropdownMenuItem(
                              value: e.name.toString(),
                              child: Text(e.id.toString()),
                            ))
                        .toList()
                    : [],
                selectedValue: selectedCarBrand,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      cubit.carBrandId = state.carTypesResponse!.data
                          .firstWhere(
                              (element) => element.name.toString() == newValue)
                          .id;
                      cubit.getCarModels(id: cubit.carBrandId);
                      selectCarModel = null;
                      selectedCarBrand = newValue;
                    });
                  }
                },
              ),
              16.verticalSpace,
              FormTitle(title: context.carModel, imagePath: AppAssets.iconsCar),
              8.verticalSpace,
              CustomDropdown(
                title: context.carModel,
                hint: context.carModel,
                items: state.carModelsResponse != null
                    ? state.carModelsResponse!.data
                        .map((e) => DropdownMenuItem(
                              value: e.name.toString(),
                              child: Text(e.id.toString()),
                            ))
                        .toList()
                    : [],
                selectedValue: selectCarModel,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      cubit.carModelId = state.carModelsResponse!.data
                          .firstWhere(
                              (element) => element.name.toString() == newValue)
                          .id;
                      selectCarModel = newValue;
                    });
                  }
                },
              ),
              16.verticalSpace,
              FormTitle(
                title: context.yearOfManufacture,
                imagePath: AppAssets.iconsLifebuoy,
              ),
              8.verticalSpace,
              CustomDropdown(
                title: context.yearOfManufacture,
                hint: context.yearOfManufacture,
                items: List.generate(
                  75,
                  (index) => DropdownMenuItem(
                    value: (DateTime.now().year - index).toString(),
                    child: Text((DateTime.now().year - index).toString()),
                  ),
                ),
                selectedValue: selectedYearOfManufacture,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      selectedYearOfManufacture = newValue;
                      cubit.carModelYear = int.parse(newValue);
                    });
                  }
                },
              ),
              16.verticalSpace,
              FormTitle(
                title: context.reportType,
                imagePath: AppAssets.iconsLifebuoy,
              ),
              8.verticalSpace,
              CustomDropdown(
                title: context.reportType,
                hint: context.reportType,
                items: ReportTypeEnum.values
                    .map((e) => DropdownMenuItem(
                          value: e.translatedName(context).toString(),
                          child: Text(e.translatedName(context).toString()),
                        ))
                    .toList(),
                selectedValue: selectReportType,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      cubit.reportType = ReportTypeEnum.values.firstWhere(
                        (e) => e.translatedName(context) == newValue,
                      );
                      selectReportType = newValue;
                    });
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
