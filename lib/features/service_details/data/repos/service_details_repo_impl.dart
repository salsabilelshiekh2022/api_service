import 'package:dartz/dartz.dart';
import 'package:elmohtaref/core/database/network/api_consumer.dart';
import 'package:elmohtaref/core/database/network/failure.dart';
import 'package:elmohtaref/features/service_details/data/service_details_model.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/database/network/end_points.dart';
import 'service_details_repo.dart';

@LazySingleton(as: ServiceDetailsRepo)
class ServiceDetailsRepoImpl implements ServiceDetailsRepo {
  final ApiConsumer apiConsumer;

  ServiceDetailsRepoImpl({required this.apiConsumer});

  @override
  Future<Either<Failure, ServiceDetailResponse>> getServiceDetails({
    required int id,
  }) async {
    return apiConsumer.handleRequest(
      request: () => apiConsumer.get(EndPoints.getServiceDetails(id: id)),
      onSuccess: (result) => ServiceDetailResponse.fromJson(result.data),
    );
  }
}
