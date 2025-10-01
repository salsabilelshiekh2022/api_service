import 'package:dartz/dartz.dart';

import '../../../../core/database/network/failure.dart';
import '../models/notification_model.dart';

abstract class NotificationRepository {
  Future<Either<Failure, NotificationsModel>> getNotifications({int page = 1});
}
