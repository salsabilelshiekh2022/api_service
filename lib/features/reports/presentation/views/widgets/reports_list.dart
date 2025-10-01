import 'package:elmohtaref/core/extensions/translation_extensions.dart';
import 'package:elmohtaref/features/reports/data/models/reports_model.dart';
import 'package:elmohtaref/features/reports/presentation/cubit/reports_cubit.dart';
import 'package:elmohtaref/features/reports/presentation/cubit/reports_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../core/components/widgets/empty_widget.dart';
import '../../../../../generated/app_assets.dart';
import 'report_list_item.dart';

class ReportsList extends StatefulWidget {
  const ReportsList({super.key, required this.search});
  final String search;

  @override
  State<ReportsList> createState() => _ReportsListState();
}

class _ReportsListState extends State<ReportsList> {
  late ScrollController _scrollController;
  String get search => widget.search;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    context.read<ReportsCubit>().fetchReports(search: search);
  }

  @override
  void didUpdateWidget(covariant ReportsList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.search != widget.search) {
      context.read<ReportsCubit>().fetchReports(search: widget.search);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<ReportsCubit>().onScrollEnd();
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9); // Trigger at 90% scroll
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportsCubit, ReportsState>(
      builder: (context, state) {
        if (state.status == ReportsStatus.loading ||
            state.status == ReportsStatus.refreshing) {
          return ListView.separated(
            controller: _scrollController,
            padding: EdgeInsets.only(bottom: 16.h),
            itemBuilder: (_, __) => Skeletonizer(
              enabled: true,
              child: ReportListItem(report: dummyReport),
            ),
            separatorBuilder: (_, __) => 12.verticalSpace,
            itemCount: 3,
          );
        }
        if (state.status == ReportsStatus.failure) {
          return Center(child: Text(state.errorMessage ?? context.errorAccure));
        }
        if (state.status == ReportsStatus.success && state.reports.isEmpty) {
          return EmptyWidget(
            imagePath: AppAssets.imagesEmptyImage,
            title: context.noReports,
            description: "",
          );
        }
        return RefreshIndicator(
          onRefresh: () => context.read<ReportsCubit>().refreshVisits(),
          child: ListView.separated(
            controller: _scrollController,
            padding: EdgeInsets.only(bottom: 16.h),
            itemBuilder: (_, index) {
              if (index < state.reports.length) {
                return ReportListItem(
                  report: state.reports[index],
                );
              }
              if (state.status == ReportsStatus.loadingMore) {
                return const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              return const SizedBox.shrink();
            },
            separatorBuilder: (_, __) => 12.verticalSpace,
            itemCount: state.reports.length +
                (state.status == ReportsStatus.loadingMore ||
                        state.hasReachedMax
                    ? 1
                    : 0),
          ),
        );
      },
    );
  }
}
