import 'package:dartz/dartz.dart';
import 'package:elmohtaref/core/database/network/app_consumer.dart';
import 'package:elmohtaref/core/database/network/failure.dart';
import 'package:elmohtaref/features/service_details/data/service_details_model.dart';

import '../../../../core/database/network/end_points.dart';
import '../../../../core/utils/app_logs.dart';
import 'service_details_repo.dart';

class ServiceDetailsRepoImpl implements ServiceDetailsRepo {
  final ApiConsumer apiConsumer;
  ServiceDetailsRepoImpl({required this.apiConsumer});
  @override
  Future<Either<Failure, ServiceDetailResponse>> getServiceDetails(
      {required int id}) async {
    try {
      final result = await apiConsumer.get(
        EndPoints.getServiceDetails(id: id),
      );

      final serviceDetailResponse = ServiceDetailResponse.fromJson(result.data);

      return Right(serviceDetailResponse);
    } catch (e) {
      AppLogs.errorLog(e.toString());
      return Left(Failure(message: e.toString()));
    }
  }
}
