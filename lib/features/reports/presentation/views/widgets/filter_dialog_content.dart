import 'package:elmohtaref/core/extensions/app_extention.dart';
import 'package:flutter/material.dart';

import 'car_brand_section.dart';
import 'date_range_section.dart';
import 'service_type_section.dart';

class FilterDialogContent extends StatelessWidget {
  const FilterDialogContent({
    super.key,
    required this.isFromReports,
  });
  final bool isFromReports;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Column(
        children: [
          ServiceTypeSection(
            isFromReports: isFromReports,
          ),
          16.verticalSizedBox,
          DateRangeSection(
            isFromReports: isFromReports,
          ),
          16.verticalSizedBox,
          CarBrandSection(
            isFromReports: isFromReports,
          ),
        ],
      ),
    );
  }
}
