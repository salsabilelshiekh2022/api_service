import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/models/setting_model.dart';
import 'setting_item_Widget.dart';

class SettingList extends StatelessWidget {
  const SettingList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 30),
      shrinkWrap: true,
      itemCount: settingItems(context).length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => SettingItemWidget(
        settingModel: settingItems(context)[index],
      ),
      separatorBuilder: (context, index) => 16.verticalSpace,
    );
  }
}
