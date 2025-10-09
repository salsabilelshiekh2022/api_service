import 'package:dartz/dartz.dart';
import 'package:elmohtaref/core/database/network/failure.dart';
import 'package:elmohtaref/features/auth/data/models/user_model.dart';
import '../../../../core/database/network/api_consumer.dart';
import '../../../../core/database/network/end_points.dart';
import '../models/edit_profile_request_model.dart';
import 'auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final ApiConsumer apiConsumer;
  AuthRepoImpl({required this.apiConsumer});

  @override
  Future<Either<Failure, String>> logout() async {
    return apiConsumer.handleRequest(
      request: () => apiConsumer.post(path: EndPoints.logout),
      onSuccess: (result) => result['meta']['message'] as String,
    );
  }

  @override
  Future<Either<Failure, String>> sendOtp({required String phone}) async {
    return apiConsumer.handleRequest(
      request: () => apiConsumer.post(
        path: EndPoints.sendOtp,
        data: {"phone": phone},
      ),
      onSuccess: (result) => result['meta']['message'] as String,
    );
  }

  @override
  Future<Either<Failure, UserModel>> verifyOtp({
    required String phone,
    required String otp,
  }) async {
    return apiConsumer.handleRequest(
      request: () => apiConsumer.post(
        path: EndPoints.verifyOtp,
        data: {
          "phone": phone,
          "otp": otp,
        },
      ),
      onSuccess: (result) => UserModel.fromJson(result),
    );
  }

  @override
  Future<Either<Failure, UserModel>> updateProfile({
    required EditProfileRequestModel editProfileRequestModel,
  }) async {
    return apiConsumer.handleRequest(
      request: () => apiConsumer.post(
        isFromData: true,
        path: EndPoints.editProfile,
        data: editProfileRequestModel.toJson(),
      ),
      onSuccess: (result) => UserModel.fromJson(result),
    );
  }

  @override
  Future<Either<Failure, String>> checkPhone({required String phone}) async {
    return apiConsumer.handleRequest(
      request: () => apiConsumer.post(
        path: EndPoints.checkPhone,
        data: {"phone": phone},
      ),
      onSuccess: (result) => result['meta']['message'] as String,
    );
  }
}
