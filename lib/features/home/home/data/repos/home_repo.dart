import 'package:dartz/dartz.dart';
import 'package:elmohtaref/features/home/home/data/models/service_model.dart';
import 'package:elmohtaref/features/home/home/data/models/social_media_response_model.dart';

import '../../../../../core/database/network/failure.dart';
import '../models/banner_model.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<BannerModel>>> getHomeBanners();
  Future<Either<Failure, List<ServiceModel>>> getHomeServices();
  Future<Either<Failure, SocialMediaResponseModel>> getSocialMedia();
  Future<Either<Failure, String>> getWorkingTimes();
}
