import 'package:dynamic_tabbar/dynamic_tabbar.dart';
import 'package:elmohtaref/core/extensions/translation_extensions.dart';
import 'package:elmohtaref/features/service_details/presentation/cubit/service_details_cubit.dart';
import 'package:elmohtaref/features/service_details/presentation/views/widget/info_section.dart';
import 'package:elmohtaref/features/service_details/presentation/views/widget/rating_section.dart';
import 'package:elmohtaref/features/service_details/presentation/views/widget/service_details_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widget/book_service_button.dart';
import 'widget/photos_section.dart';
import 'widget/service_info.dart';

class ServiceDetailsView extends StatefulWidget {
  const ServiceDetailsView({super.key, required this.id, required this.title});
  final int id;
  final String title;

  @override
  State<ServiceDetailsView> createState() => _ServiceDetailsViewState();
}

class _ServiceDetailsViewState extends State<ServiceDetailsView>
    with TickerProviderStateMixin {
  late TabController _tabController;

  List<TabData> tabs({required BuildContext context}) => [
        TabData(
          index: 1,
          title: Tab(
            child: Text(context.info),
          ),
          content: const InfoSection(),
        ),
        TabData(
          index: 2,
          title: Tab(
            child: Text(context.photos),
          ),
          content: const PhotosSection(),
        ),
        TabData(
          index: 3,
          title: Tab(
            child: Text(context.rate),
          ),
          content: const RatingSection(),
        ),
      ];

  @override
  void initState() {
    super.initState();
    context.read<ServiceDetailsCubit>().getServiceDetails(id: widget.id);
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: BookServiceButton(
        title: widget.title,
        serviceId: widget.id,
      ),
      body: Column(
        children: [
          const ServiceDetailsHeader(),
          const ServiceInfo(),
          Expanded(
            child: DynamicTabBarWidget(
              dynamicTabs: tabs(context: context),
              isScrollable: false,
              onTabControllerUpdated: (controller) {
                controller.animateTo(0);
              },
              onTabChanged: (index) {},
              onAddTabMoveTo: MoveToTab.first,
              showBackIcon: false,
              showNextIcon: false,
            ),
          ),
        ],
      ),
    );
  }
}
