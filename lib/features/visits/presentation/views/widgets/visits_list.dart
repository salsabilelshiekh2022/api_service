import 'package:elmohtaref/core/extensions/translation_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../core/components/widgets/app_snack_bar.dart';
import '../../../../../core/components/widgets/empty_widget.dart';
import '../../../../../generated/app_assets.dart';
import '../../../cubit/visits_cubit.dart';
import '../../../cubit/visits_state.dart';
import '../../../data/models/visit_model.dart';
import 'visit_list_item.dart';

class VisitsList extends StatefulWidget {
  final String search;
  const VisitsList({super.key, this.search = ''});

  @override
  State<VisitsList> createState() => _VisitsListState();
}

class _VisitsListState extends State<VisitsList> {
  late ScrollController _scrollController;
  String get search => widget.search;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    context.read<VisitsCubit>().fetchVisits(search: search);
  }

  @override
  void didUpdateWidget(covariant VisitsList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.search != widget.search) {
      context.read<VisitsCubit>().fetchVisits(search: widget.search);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<VisitsCubit>().onScrollEnd();
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
    return BlocConsumer<VisitsCubit, VisitsState>(
      listener: (context, state) {
        if (state.isRateVisitSuccess) {
          AppSnackBar.showSnackBar(
            context: context,
            message: state.successMessage ?? context.successVisitRating,
            state: SnackBarStates.success,
          );
        } else if (state.isRateVisitFailure) {
          AppSnackBar.showSnackBar(
            context: context,
            message: state.errorMessage ?? context.failedVisitRating,
            state: SnackBarStates.error,
          );
        }
      },
      builder: (context, state) {
        if (state.status == VisitsStatus.loading ||
            state.status == VisitsStatus.refreshing) {
          return ListView.separated(
            controller: _scrollController,
            padding: EdgeInsets.only(bottom: 16.h),
            itemBuilder: (_, __) => Skeletonizer(
              enabled: true,
              child: VisitListItem(visit: dummyVisit),
            ),
            separatorBuilder: (_, __) => 12.verticalSpace,
            itemCount: 3,
          );
        }
        if (state.status == VisitsStatus.failure) {
          return Center(child: Text(state.errorMessage ?? context.errorAccure));
        }
        if (state.status == VisitsStatus.success && state.visits.isEmpty) {
          return EmptyWidget(
            imagePath: AppAssets.imagesEmptyImage,
            title: context.noVisits,
            description: context.noVisits,
          );
        }
        return RefreshIndicator(
          onRefresh: () => context.read<VisitsCubit>().refreshVisits(),
          child: ListView.separated(
            controller: _scrollController,
            padding: EdgeInsets.only(bottom: 16.h),
            itemBuilder: (_, index) {
              if (index < state.visits.length) {
                return VisitListItem(
                  visit: state.visits[index],
                );
              }
              if (state.status == VisitsStatus.loadingMore) {
                return const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              return const SizedBox.shrink();
            },
            separatorBuilder: (_, __) => 12.verticalSpace,
            itemCount: state.visits.length +
                (state.status == VisitsStatus.loadingMore || state.hasReachedMax
                    ? 1
                    : 0),
          ),
        );
      },
    );
  }
}
