import 'package:equatable/equatable.dart';

import '../../data/models/notification_model.dart';

enum NotificationStateStatus {
  initial,
  loading,
  loadingMore,
  success,
  failure,
  refreshing,
}

class NotificationState extends Equatable {
  final NotificationStateStatus status;
  final NotificationsModel? notifications;
  final List<NotificationData> notificationList;
  final String? errorMessage;
  final bool hasReachedMax;
  final int currentPage;

  const NotificationState({
    this.status = NotificationStateStatus.initial,
    this.notifications,
    this.notificationList = const [],
    this.errorMessage,
    this.hasReachedMax = false,
    this.currentPage = 1,
  });

  NotificationState copyWith({
    NotificationStateStatus? status,
    NotificationsModel? notifications,
    List<NotificationData>? notificationList,
    String? errorMessage,
    bool? hasReachedMax,
    int? currentPage,
  }) {
    return NotificationState(
      status: status ?? this.status,
      notifications: notifications ?? this.notifications,
      notificationList: notificationList ?? this.notificationList,
      errorMessage: errorMessage ?? this.errorMessage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  // Convenience getters
  bool get isInitial => status == NotificationStateStatus.initial;
  bool get isLoading => status == NotificationStateStatus.loading;
  bool get isLoadingMore => status == NotificationStateStatus.loadingMore;
  bool get isSuccess => status == NotificationStateStatus.success;
  bool get isFailure => status == NotificationStateStatus.failure;
  bool get isRefreshing => status == NotificationStateStatus.refreshing;

  bool get isEmpty => isSuccess && notificationList.isEmpty;
  bool get isNotEmpty => isSuccess && notificationList.isNotEmpty;

  int get totalNotifications => notifications?.meta?.total ?? 0;
  //int get unreadCount => notificationList.where((n) => !n?.isRead).length;

  @override
  List<Object?> get props => [
        status,
        notifications,
        notificationList,
        errorMessage,
        hasReachedMax,
        currentPage,
      ];
}
