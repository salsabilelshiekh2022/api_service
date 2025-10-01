import 'package:dartz/dartz.dart';
import 'package:elmohtaref/core/database/network/failure.dart';
import 'package:elmohtaref/features/auth/data/models/user_model.dart';

import '../models/edit_profile_request_model.dart';

abstract class AuthRepo {
  Future<Either<Failure, String>> sendOtp({required String phone});
  Future<Either<Failure, UserModel>> verifyOtp({
    required String phone,
    required String otp,
  });
  Future<Either<Failure, String>> logout();
  Future<Either<Failure, UserModel>> updateProfile({
    required EditProfileRequestModel editProfileRequestModel,
  });
  Future<Either<Failure, String>> checkPhone({required String phone});
}
