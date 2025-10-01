import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:elmohtaref/core/database/network/failure.dart';
import 'package:elmohtaref/features/reports/data/models/reports_model.dart';
import 'package:elmohtaref/features/reports/data/repos/reports_repo.dart'
    show ReportsRepo;

import '../../../../core/database/network/app_consumer.dart';
import '../../../../core/database/network/end_points.dart';

class ReportsRepoImpl implements ReportsRepo {
  final ApiConsumer apiConsumer;

  ReportsRepoImpl({required this.apiConsumer});

  @override
  Future<Either<Failure, ReportsResponse>> getReports(
      {int page = 1,
      String? search,
      String? fromDate,
      String? toDate,
      int? carTypeId,
      int? serviceId}) async {
    try {
      final result = await apiConsumer.get(
        EndPoints.reports,
        queryParameters: {
          'page': page,
          'search': search,
          'date_from': fromDate,
          'date_to': toDate,
          'car_type_id': carTypeId,
          'service_id': serviceId,
        },
      );
      final Map<String, dynamic> jsonData = result.data as Map<String, dynamic>;
      return Right(ReportsResponse.fromJson(jsonData));
    } on SocketException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
