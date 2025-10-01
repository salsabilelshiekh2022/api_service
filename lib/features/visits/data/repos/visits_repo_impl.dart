import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:elmohtaref/core/database/network/app_consumer.dart';
import 'package:elmohtaref/core/database/network/failure.dart';
import 'package:elmohtaref/features/visits/data/models/visit_model.dart';
import 'package:elmohtaref/features/visits/data/repos/visits_repo.dart';

import '../../../../core/database/network/end_points.dart';
import '../models/visit_enum_status.dart';

class VisitsRepoImpl implements VisitsRepo {
  final ApiConsumer _apiConsumer;
  VisitsRepoImpl(this._apiConsumer);
  @override
  Future<Either<Failure, VisitsResponse>> getVisits(
      {int page = 1,
      String? search,
      int? serviceId,
      String? fromDate,
      String? toDate,
      int? carTypeId,
      VisitEnumStatus? status}) async {
    try {
      final result = await _apiConsumer.get(
        EndPoints.visits,
        queryParameters: {
          'page': page,
          'search': search,
          'service_id': serviceId,
          'date_from': fromDate,
          'date_to': toDate,
          'car_type_id': carTypeId,
          'status': status?.name,
        },
      );
      final Map<String, dynamic> jsonData = result.data as Map<String, dynamic>;
      return Right(VisitsResponse.fromJson(jsonData));
    } on SocketException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> rateVisit(
      {required rateRequestModel, required int visitId}) async {
    try {
      final result = await _apiConsumer.post(
        isFromData: true,
        path: EndPoints.rateVisit(id: visitId),
        data: rateRequestModel.toJson(),
      );
      return Right(result['meta']['message']);
    } on SocketException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
