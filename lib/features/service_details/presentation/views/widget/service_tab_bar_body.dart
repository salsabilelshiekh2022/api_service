import 'package:flutter/material.dart';

import 'info_section.dart';
import 'photos_section.dart';
import 'rating_section.dart';

class ServiceTabBarBody extends StatelessWidget {
  const ServiceTabBarBody({
    super.key,
    required TabController tabController,
  }) : _tabController = tabController;

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      physics: NeverScrollableScrollPhysics(),
      controller: _tabController,
      children: const <Widget>[
        InfoSection(),
        PhotosSection(),
        RatingSection(),
      ],
    );
  }
}
