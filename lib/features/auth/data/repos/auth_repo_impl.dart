import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:elmohtaref/core/database/network/failure.dart';
import 'package:elmohtaref/core/utils/app_logs.dart';
import 'package:elmohtaref/features/auth/data/models/user_model.dart';

import '../../../../core/database/network/app_consumer.dart';
import '../../../../core/database/network/end_points.dart';
import '../models/edit_profile_request_model.dart';
import 'auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final ApiConsumer apiConsumer;
  AuthRepoImpl({required this.apiConsumer});
  @override
  Future<Either<Failure, String>> logout() async {
    try {
      final result = await apiConsumer.post(
        path: EndPoints.logout,
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
  Future<Either<Failure, String>> sendOtp({required String phone}) async {
    try {
      final result = await apiConsumer.post(
        path: EndPoints.sendOtp,
        data: {"phone": phone},
      );
      return Right(result['meta']['message']);
    } on SocketException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      AppLogs.errorLog(e.toString());
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserModel>> verifyOtp({
    required String phone,
    required String otp,
  }) async {
    try {
      final result = await apiConsumer.post(
        path: EndPoints.verifyOtp,
        data: {
          "phone": phone,
          "otp": otp,
        },
      );
      return Right(UserModel.fromJson(result));
    } on SocketException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserModel>> updateProfile(
      {required EditProfileRequestModel editProfileRequestModel}) async {
    try {
      final result = await apiConsumer.post(
        isFromData: true,
        path: EndPoints.editProfile,
        data: editProfileRequestModel.toJson(),
      );
      return Right(UserModel.fromJson(result));
    } on SocketException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> checkPhone({required String phone}) async {
    try {
      final result = await apiConsumer.post(
        path: EndPoints.checkPhone,
        data: {
          "phone": phone,
        },
      );
      return Right(
        result['meta']['message'],
      );
    } on SocketException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
