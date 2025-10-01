import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../data/models/service_model.dart';
import '../../cubit/home_cubit.dart';
import 'service_grid_item.dart';

class ServicesGridView extends StatelessWidget {
  const ServicesGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 225.h,
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          bool isLoading = state.services == null;
          bool isSuccess = state.services != null;
          return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: isLoading
                  ? 6
                  : isSuccess
                      ? state.services!.length
                      : 6,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 0,
                  crossAxisSpacing: 0,
                  mainAxisExtent: 110),
              itemBuilder: (context, index) => Skeletonizer(
                  enabled: state.isServicesLoading,
                  child: ServiceGridItem(
                    service: isLoading
                        ? dummyService
                        : isSuccess
                            ? state.services![index]
                            : dummyService,
                  )));
        },
      ),
    );
  }
}
