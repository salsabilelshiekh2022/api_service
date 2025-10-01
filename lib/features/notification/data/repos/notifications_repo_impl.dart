// notification_repository_impl.dart (Implementation example)
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/database/network/app_consumer.dart';
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
    try {
      final result = await _apiConsumer.get(
        EndPoints.notifications,
        queryParameters: {'page': page},
      );
      final Map<String, dynamic> jsonData = result.data as Map<String, dynamic>;
      return Right(NotificationsModel.fromJson(jsonData));
    } on SocketException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
