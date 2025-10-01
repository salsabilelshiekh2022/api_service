import 'package:elmohtaref/core/extensions/translation_extensions.dart';
import 'package:elmohtaref/features/home/home/presentation/cubit/home_cubit.dart';
import 'package:elmohtaref/features/visits/cubit/visits_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../core/components/widgets/custom_drop_down.dart';
import '../../cubit/reports_cubit.dart';
import 'section_title.dart';

class ServiceTypeSection extends StatefulWidget {
  const ServiceTypeSection({super.key, required this.isFromReports});
  final bool isFromReports;

  @override
  State<ServiceTypeSection> createState() => _ServiceTypeSectionState();
}

class _ServiceTypeSectionState extends State<ServiceTypeSection> {
  String? selectedServiceType;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SectionTitle(title: context.serviceType),
            const SizedBox(height: 12),
            Skeletonizer(
              enabled: state.isServicesLoading,
              child: CustomDropdown(
                title: context.serviceType,
                hint: context.all,
                items: state.services != null
                    ? state.services!.map((service) {
                        return DropdownMenuItem(
                          value: service.name.toString(),
                          child: Text(service.name),
                        );
                      }).toList()
                    : [],
                selectedValue: selectedServiceType,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      widget.isFromReports
                          ? context.read<ReportsCubit>().state.serviceId = state
                              .services!
                              .firstWhere((service) => service.name == newValue)
                              .id
                          : context.read<VisitsCubit>().state.serviceId = state
                              .services!
                              .firstWhere((service) => service.name == newValue)
                              .id;
                      selectedServiceType = newValue;
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
