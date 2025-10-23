import 'package:dartz/dartz.dart';
import 'package:elmohtaref/core/database/network/end_points.dart';
import 'package:elmohtaref/core/database/network/failure.dart';
import 'package:elmohtaref/features/home/home/data/models/banner_model.dart';
import 'package:elmohtaref/features/home/home/data/models/service_model.dart';
import 'package:elmohtaref/features/home/home/data/models/social_media_response_model.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/database/network/api_consumer.dart';
import 'home_repo.dart';

@LazySingleton(as: HomeRepo)
class HomeRepoImpl implements HomeRepo {
  final ApiConsumer apiConsumer;

  HomeRepoImpl({required this.apiConsumer});

  @override
  Future<Either<Failure, List<BannerModel>>> getHomeBanners() async {
    return apiConsumer.handleRequest(
      request: () => apiConsumer.get(EndPoints.homeBanners),
      onSuccess: (result) {
        final List<dynamic> responseData = result.data['data'];
        return responseData.map((x) => BannerModel.fromJson(x)).toList();
      },
    );
  }

  @override
  Future<Either<Failure, List<ServiceModel>>> getHomeServices() async {
    return apiConsumer.handleRequest(
      request: () => apiConsumer.get(EndPoints.homeServices),
      onSuccess: (result) {
        final List<dynamic> responseData = result.data['data'];
        return responseData.map((x) => ServiceModel.fromJson(x)).toList();
      },
    );
  }

  @override
  Future<Either<Failure, SocialMediaResponseModel>> getSocialMedia() async {
    return apiConsumer.handleRequest(
      request: () => apiConsumer.get(EndPoints.getSocialMediaLinks),
      onSuccess: (result) => SocialMediaResponseModel.fromJson(result.data),
    );
  }

  @override
  Future<Either<Failure, String>> getWorkingTimes() async {
    return apiConsumer.handleRequest(
      request: () => apiConsumer.get(EndPoints.workingTimes),
      onSuccess: (result) => result.data['data']['working_times'] as String,
    );
  }
}
