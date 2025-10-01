import 'package:dartz/dartz.dart';
import 'package:elmohtaref/core/database/network/end_points.dart';
import 'package:elmohtaref/core/database/network/failure.dart';
import 'package:elmohtaref/core/utils/app_logs.dart';
import 'package:elmohtaref/features/home/home/data/models/banner_model.dart';
import 'package:elmohtaref/features/home/home/data/models/service_model.dart';
import 'package:elmohtaref/features/home/home/data/models/social_media_response_model.dart';

import '../../../../../core/database/network/app_consumer.dart';
import 'home_repo.dart';

class HomeRepoImpl implements HomeRepo {
  final ApiConsumer apiConsumer;
  HomeRepoImpl({required this.apiConsumer});
  @override
  Future<Either<Failure, List<BannerModel>>> getHomeBanners() async {
    try {
      final result = await apiConsumer.get(
        EndPoints.homeBanners,
      );
      final List<dynamic> responseData = result.data['data'];
      final banners = responseData.map((x) => BannerModel.fromJson(x)).toList();
      return Right(banners);
    } catch (e) {
      AppLogs.errorLog(e.toString());
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ServiceModel>>> getHomeServices() async {
    try {
      final result = await apiConsumer.get(
        EndPoints.homeServices,
      );
      final List<dynamic> responseData = result.data['data'];
      final services =
          responseData.map((x) => ServiceModel.fromJson(x)).toList();
      return Right(services);
    } catch (e) {
      AppLogs.errorLog(e.toString());
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, SocialMediaResponseModel>> getSocialMedia() async {
    try {
      final result = await apiConsumer.get(
        EndPoints.getSocialMediaLinks,
      );

      final socialMediaResponse =
          SocialMediaResponseModel.fromJson(result.data);

      return Right(socialMediaResponse);
    } catch (e) {
      AppLogs.errorLog(e.toString());
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> getWorkingTimes() async {
    try {
      final result = await apiConsumer.get(
        EndPoints.workingTimes,
      );
      return Right(result.data['data']['working_times']);
    } catch (e) {
      AppLogs.errorLog(e.toString());
      return Left(Failure(message: e.toString()));
    }
  }
}
