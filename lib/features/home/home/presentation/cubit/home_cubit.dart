import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/database/network/failure.dart';
import '../../data/models/banner_model.dart';
import '../../data/models/service_model.dart';
import '../../data/models/social_media_response_model.dart';
import '../../data/repos/home_repo.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._homeRepo) : super(HomeState(status: HomeStatus.initial));
  final HomeRepo _homeRepo;

  Future<void> getHomeBanners() async {
    emit(state.copyWith(status: HomeStatus.getBannersLoading));
    final result = await _homeRepo.getHomeBanners();
    result.fold(
        (l) => emit(state.copyWith(
              status: HomeStatus.getBannersFailure,
              failure: l,
            )),
        (r) => emit(state.copyWith(
              status: HomeStatus.getBannersSuccess,
              banners: r,
            )));
  }

  Future<void> getHomeServices() async {
    emit(state.copyWith(
      status: HomeStatus.getServicesLoading,
    ));
    final result = await _homeRepo.getHomeServices();
    result.fold(
        (l) => emit(
            state.copyWith(status: HomeStatus.getServicesFailure, failure: l)),
        (r) => emit(state.copyWith(
            status: HomeStatus.getServicesSuccess, services: r)));
  }

  Future<void> getSocialMedia() async {
    emit(state.copyWith(status: HomeStatus.getSocialMediaLoading));
    final result = await _homeRepo.getSocialMedia();
    result.fold(
        (l) => emit(state.copyWith(
              status: HomeStatus.getSocialMediaFailure,
              failure: l,
            )),
        (r) => emit(state.copyWith(
              status: HomeStatus.getSocialMediaSuccess,
              socialMedia: r,
            )));
  }

  Future<void> getWorkingTimes() async {
    emit(state.copyWith(status: HomeStatus.getWorkingTimesLoading));
    final result = await _homeRepo.getWorkingTimes();
    result.fold(
        (l) => emit(state.copyWith(
              status: HomeStatus.getWorkingTimesFailure,
              failure: l,
            )),
        (r) => emit(state.copyWith(
              status: HomeStatus.getWorkingTimesSuccess,
              workingTimes: r,
            )));
  }
}
