import 'package:elmohtaref/core/extensions/app_extention.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/components/widgets/custom_cache_network_image.dart';
import '../../../../../../core/routes/routes.dart';
import '../../../../../../core/theme/app_text_style.dart';
import '../../../data/models/service_model.dart';

class ServiceGridItem extends StatelessWidget {
  const ServiceGridItem({super.key, required this.service});
  final ServiceModel service;

  @override
  Widget build(BuildContext context) {
    final appTextStyles = Theme.of(context).extension<AppTextStyles>()!;
    return InkWell(
      onTap: () {
        context.pushNamed(Routes.serviceDetailsView, arguments: {
          "id": service.id,
          "title": service.name,
        });
      },
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(34.r),
            child: CustomCachedImageWidget(
              path: service.mainImage,
              width: 68,
              height: 68,
              fit: BoxFit.cover,
            ),
          ),
          8.verticalSpace,
          Text(
            service.name,
            overflow: TextOverflow.ellipsis,
            style: appTextStyles.font14RegularSecondaryColor,
          )
        ],
      ),
    );
  }
}
