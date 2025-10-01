import 'package:elmohtaref/core/extensions/translation_extensions.dart';
import 'package:elmohtaref/generated/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../core/components/widgets/empty_widget.dart';
import '../../../data/models/notification_model.dart';
import '../../cubit/notifications_cubit.dart';
import '../../cubit/notifications_state.dart';
import 'notification_list_item.dart';

class NotificationsList extends StatefulWidget {
  const NotificationsList({super.key});

  @override
  State<NotificationsList> createState() => _NotificationsListState();
}

class _NotificationsListState extends State<NotificationsList> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    context.read<NotificationCubit>().getNotifications();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<NotificationCubit>().loadMore();
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationCubit, NotificationState>(
      builder: (context, state) {
        bool isInitialLoading =
            state.isLoading && state.notificationList.isEmpty;
        if (state.isSuccess && state.notificationList.isEmpty) {
          return EmptyWidget(
            imagePath: AppAssets.imagesEmptyNotification,
            title: context.noNotifications,
            description: context.noNotificationsDiscription,
          );
        }

        return RefreshIndicator(
          onRefresh: () =>
              context.read<NotificationCubit>().refreshNotifications(),
          child: ListView.separated(
            controller: _scrollController,
            padding: EdgeInsets.only(bottom: 16.h),
            itemBuilder: (_, index) {
              if (isInitialLoading) {
                return Skeletonizer(
                  enabled: true,
                  child: NotificationListItem(notification: dummyNotification),
                );
              }
              if (index < state.notificationList.length) {
                return NotificationListItem(
                  notification: state.notificationList[index],
                );
              }
              if (state.isLoadingMore) {
                return const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              return const SizedBox.shrink();
            },
            separatorBuilder: (_, index) {
              return 12.verticalSpace;
            },
            itemCount: isInitialLoading
                ? 5
                : state.notificationList.length +
                    (state.isLoadingMore || state.hasReachedMax ? 1 : 0),
          ),
        );
      },
    );
  }
}
