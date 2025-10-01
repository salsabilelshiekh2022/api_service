import 'package:elmohtaref/core/extensions/translation_extensions.dart';
import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';

class ServiceTabBar extends StatelessWidget {
  const ServiceTabBar({
    super.key,
    required TabController tabController,
  }) : _tabController = tabController;

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return SliverPersistentHeader(
      delegate: _SliverAppBarDelegate(
        TabBar(
          overlayColor: WidgetStateProperty.all(Colors.transparent),
          indicatorColor: appColors.primaryColor,
          labelColor: appColors.primaryColor,
          unselectedLabelColor: appColors.secondaryColor,
          indicatorSize: TabBarIndicatorSize.label,
          controller: _tabController,
          tabs: <Widget>[
            Tab(child: Text(context.info)),
            Tab(child: Text(context.photos)),
            Tab(child: Text(context.rate)),
          ],
        ),
      ),
      pinned: true,
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
