import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:elmohtaref/core/database/network/app_consumer.dart';
import 'package:elmohtaref/core/database/network/failure.dart';
import 'package:elmohtaref/features/book_service/data/models/book_service_request_model.dart';
import 'package:elmohtaref/features/book_service/data/models/car_type_model.dart';
import 'package:elmohtaref/features/book_service/data/models/time_slots_model.dart';

import '../../../../core/database/network/end_points.dart';
import 'book_service_repo.dart';

class BookServiceRepoImpl implements BookServiceRepo {
  final ApiConsumer apiConsumer;

  BookServiceRepoImpl({required this.apiConsumer});
  @override
  Future<Either<Failure, String>> bookService(
      {required BookServiceRequestModel bookServiceModel}) async {
    try {
      final result = await apiConsumer.post(
        isFromData: true,
        path: EndPoints.bookAService,
        data: bookServiceModel.toJson(),
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

  @override
  Future<Either<Failure, CarTypesResponse>> getCarTypes() async {
    try {
      final result = await apiConsumer.get(
        EndPoints.getCarTypes,
      );
      final Map<String, dynamic> jsonData = result.data as Map<String, dynamic>;
      return Right(CarTypesResponse.fromJson(jsonData));
    } on SocketException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, CarTypesResponse>> getCarModels(
      {required int id}) async {
    try {
      final result = await apiConsumer.get(
        EndPoints.getCarModels(id: id),
      );
      final Map<String, dynamic> jsonData = result.data as Map<String, dynamic>;
      return Right(CarTypesResponse.fromJson(jsonData));
    } on SocketException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, TimeSlotsResponse>> getTimeAvilability(
      {required int serviceId, String? day}) async {
    try {
      final result = await apiConsumer.get(EndPoints.getTimeAvalability,
          queryParameters: {"service_id": serviceId, "day": day});
      final Map<String, dynamic> jsonData = result.data as Map<String, dynamic>;
      return Right(TimeSlotsResponse.fromJson(jsonData));
    } on SocketException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
