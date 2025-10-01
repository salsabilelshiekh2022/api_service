part of 'home_cubit.dart';

enum HomeStatus {
  initial,
  getBannersLoading,
  getBannersSuccess,
  getBannersFailure,
  getServicesLoading,
  getServicesSuccess,
  getServicesFailure,
  getSocialMediaLoading,
  getSocialMediaSuccess,
  getSocialMediaFailure,
  getWorkingTimesLoading,
  getWorkingTimesSuccess,
  getWorkingTimesFailure
}

final class HomeState extends Equatable {
  final HomeStatus status;
  final List<BannerModel>? banners;
  final List<ServiceModel>? services;
  final Failure? failure;
  final SocialMediaResponseModel? socialMedia;
  final String? workingTimes;

  const HomeState(
      {this.status = HomeStatus.initial,
      this.banners,
      this.services,
      this.failure,
      this.socialMedia,
      this.workingTimes});

  HomeState copyWith(
      {HomeStatus? status,
      List<BannerModel>? banners,
      List<ServiceModel>? services,
      Failure? failure,
      SocialMediaResponseModel? socialMedia,
      String? workingTimes}) {
    return HomeState(
        status: status ?? this.status,
        banners: banners ?? this.banners,
        services: services ?? this.services,
        failure: failure ?? this.failure,
        socialMedia: socialMedia ?? this.socialMedia,
        workingTimes: workingTimes ?? this.workingTimes);
  }

  // Convenience getters for checking status
  bool get isInitial => status == HomeStatus.initial;
  bool get isBannersLoading => status == HomeStatus.getBannersLoading;
  bool get isBannersSuccess => status == HomeStatus.getBannersSuccess;
  bool get isBannersFailure => status == HomeStatus.getBannersFailure;
  bool get isServicesLoading => status == HomeStatus.getServicesLoading;
  bool get isServicesSuccess => status == HomeStatus.getServicesSuccess;
  bool get isServicesFailure => status == HomeStatus.getServicesFailure;
  bool get isSocialMediaLoading => status == HomeStatus.getSocialMediaLoading;
  bool get isSocialMediaSuccess => status == HomeStatus.getSocialMediaSuccess;
  bool get isSocialMediaFailure => status == HomeStatus.getSocialMediaFailure;
  bool get isWorkingTimesLoading => status == HomeStatus.getWorkingTimesLoading;
  bool get isWorkingTimesSuccess => status == HomeStatus.getWorkingTimesSuccess;
  bool get isWorkingTimesFailure => status == HomeStatus.getWorkingTimesFailure;

  @override
  List<Object?> get props =>
      [status, banners, services, failure, socialMedia, workingTimes];
}
