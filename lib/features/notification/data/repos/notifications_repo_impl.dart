import 'package:dartz/dartz.dart';
import '../../../../core/database/network/api_consumer.dart';
import '../../../../core/database/network/end_points.dart';
import '../../../../core/database/network/failure.dart';
import '../models/notification_model.dart';
import 'notifications_repo.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final ApiConsumer _apiConsumer;

  NotificationRepositoryImpl(this._apiConsumer);

  @override
  Future<Either<Failure, NotificationsModel>> getNotifications({
    int page = 1,
  }) async {
    return _apiConsumer.handleRequest(
      request: () => _apiConsumer.get(
        EndPoints.notifications,
        queryParameters: {'page': page},
      ),
      onSuccess: (result) {
        final Map<String, dynamic> jsonData =
            result.data as Map<String, dynamic>;
        return NotificationsModel.fromJson(jsonData);
      },
    );
  }
}
