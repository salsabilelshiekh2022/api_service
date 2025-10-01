import 'package:dartz/dartz.dart';
import 'package:elmohtaref/core/database/network/failure.dart';

import '../service_details_model.dart';

abstract class ServiceDetailsRepo {
  Future<Either<Failure, ServiceDetailResponse>> getServiceDetails(
      {required int id});
}
