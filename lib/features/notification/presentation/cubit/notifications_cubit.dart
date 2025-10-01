import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;

import '../../data/models/notification_model.dart';
import '../../data/repos/notifications_repo.dart';
import 'notifications_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final NotificationRepository _repository;

  NotificationCubit(this._repository) : super(const NotificationState());

  Future<void> getNotifications() async {
    emit(state.copyWith(status: NotificationStateStatus.loading));
    final result = await _repository.getNotifications(page: 1);
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: NotificationStateStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (notifications) {
        final hasReachedMax = _checkIfReachedMax(notifications);
        emit(
          state.copyWith(
            status: NotificationStateStatus.success,
            notifications: notifications,
            notificationList: notifications.notificationsList ?? [],
            currentPage: 1,
            hasReachedMax: hasReachedMax,
          ),
        );
      },
    );
  }

  Future<void> loadMore() async {
    if (state.hasReachedMax || state.isLoadingMore) return;

    emit(state.copyWith(status: NotificationStateStatus.loadingMore));

    final nextPage = state.currentPage + 1;
    final result = await _repository.getNotifications(page: nextPage);

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: NotificationStateStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (notifications) {
        final newNotifications = notifications.notificationsList ?? [];
        final updatedList = List<NotificationData>.from(state.notificationList)
          ..addAll(newNotifications);

        final hasReachedMax =
            _checkIfReachedMax(notifications) || newNotifications.isEmpty;

        emit(
          state.copyWith(
            status: NotificationStateStatus.success,
            notifications: notifications,
            notificationList: updatedList,
            currentPage: nextPage,
            hasReachedMax: hasReachedMax,
          ),
        );
      },
    );
  }

  Future<void> refreshNotifications() async {
    emit(state.copyWith(status: NotificationStateStatus.refreshing));

    final result = await _repository.getNotifications(page: 1);
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: NotificationStateStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (notifications) {
        final hasReachedMax = _checkIfReachedMax(notifications);
        emit(
          state.copyWith(
            status: NotificationStateStatus.success,
            notifications: notifications,
            notificationList: notifications.notificationsList ?? [],
            currentPage: 1,
            hasReachedMax: hasReachedMax,
          ),
        );
      },
    );
  }

  bool _checkIfReachedMax(NotificationsModel notifications) {
    if (notifications.meta == null) return true;

    final currentPage = notifications.meta!.currentPage ?? 1;
    final lastPage = notifications.meta!.lastPage ?? 1;

    return currentPage >= lastPage;
  }
}
