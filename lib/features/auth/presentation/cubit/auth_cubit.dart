import 'package:elmohtaref/core/database/network/failure.dart';
import 'package:elmohtaref/features/auth/data/repos/auth_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/database/cache/cache_helper.dart';
import '../../../../core/database/cache/cache_services.dart';
import '../../../../core/utils/user_cache_service.dart';
import '../../data/models/edit_profile_request_model.dart';
import '../../data/models/user_model.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepo) : super(AuthInitial());
  final AuthRepo authRepo;

  Future<void> sendOtp({required String phone}) async {
    emit(SendOtpLoadingState());
    final result = await authRepo.sendOtp(phone: phone);
    result.fold(
      (failure) => emit(SendOtpErrorState(failure: failure)),
      (message) => emit(
        SendOtpSuccessState(
          message: message,
        ),
      ),
    );
  }

  void verifyOtp({
    required String phone,
    required String otp,
  }) async {
    emit(VerifyOtpLoadingState());
    final result = await authRepo.verifyOtp(
      phone: phone,
      otp: otp,
    );
    result.fold((failure) => emit(VerifyOtpErrorState(failure: failure)),
        (userModel) async {
      await CacheServices().storeData<UserModel>(
        boxName: CacheBoxes.userModelBox,
        key: 'user',
        data: userModel,
      );
      return emit(VerifyOtpSuccessState(userModel: userModel));
    });
  }

  void logout() async {
    emit(LogoutLoadingState());
    final result = await authRepo.logout();
    result.fold((failure) => emit(LogoutErrorState(failure: failure)),
        (message) => emit(LogoutSuccessState(message: message)));
  }

  Future<void> updateProfile({
    required EditProfileRequestModel editProfileRequestModel,
  }) async {
    emit(EditProfileLoadingState());
    final failureOrUser = await authRepo.updateProfile(
      editProfileRequestModel: editProfileRequestModel,
    );
    failureOrUser.fold((failure) {
      emit(EditProfileErrorState(failure: failure));
    }, (user) async {
      user.meta?.token = UserCacheService().currentUser!.meta?.token;
      await CacheServices().storeData<UserModel>(
        boxName: CacheBoxes.userModelBox,
        key: 'user',
        data: user,
      );
      emit(EditProfileSuccessState(userModel: user));
    });
  }

  Future<void> checkPhone({required String phone}) async {
    emit(CheckPhoneLoadingState());
    final result = await authRepo.checkPhone(phone: phone);
    result.fold(
      (failure) => emit(CheckPhoneErrorState(failure: failure)),
      (message) async {
        await sendOtp(phone: phone);
        //  emit(CheckPhoneSuccessState(message: message));
      },
    );
  }
}
