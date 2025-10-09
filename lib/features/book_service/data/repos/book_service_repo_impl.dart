import 'package:dartz/dartz.dart';
import 'package:elmohtaref/core/database/network/api_consumer.dart';
import 'package:elmohtaref/core/database/network/failure.dart';
import 'package:elmohtaref/features/book_service/data/models/book_service_request_model.dart';
import 'package:elmohtaref/features/book_service/data/models/car_type_model.dart';
import 'package:elmohtaref/features/book_service/data/models/time_slots_model.dart';
import '../../../../core/database/network/end_points.dart';
import 'book_service_repo.dart';

class BookServiceRepoImpl implements BookServiceRepo {
  final ApiConsumer apiConsumer;

  BookServiceRepoImpl({required this.apiConsumer});

  @override
  Future<Either<Failure, String>> bookService({
    required BookServiceRequestModel bookServiceModel,
  }) async {
    return apiConsumer.handleRequest(
      request: () => apiConsumer.post(
        isFromData: true,
        path: EndPoints.bookAService,
        data: bookServiceModel.toJson(),
      ),
      onSuccess: (result) => result['meta']['message'] as String,
    );
  }

  @override
  Future<Either<Failure, CarTypesResponse>> getCarTypes() async {
    return apiConsumer.handleRequest(
      request: () => apiConsumer.get(EndPoints.getCarTypes),
      onSuccess: (result) {
        final Map<String, dynamic> jsonData =
            result.data as Map<String, dynamic>;
        return CarTypesResponse.fromJson(jsonData);
      },
    );
  }

  @override
  Future<Either<Failure, CarTypesResponse>> getCarModels({
    required int id,
  }) async {
    return apiConsumer.handleRequest(
      request: () => apiConsumer.get(EndPoints.getCarModels(id: id)),
      onSuccess: (result) {
        final Map<String, dynamic> jsonData =
            result.data as Map<String, dynamic>;
        return CarTypesResponse.fromJson(jsonData);
      },
    );
  }

  @override
  Future<Either<Failure, TimeSlotsResponse>> getTimeAvilability({
    required int serviceId,
    String? day,
  }) async {
    return apiConsumer.handleRequest(
      request: () => apiConsumer.get(
        EndPoints.getTimeAvalability,
        queryParameters: {"service_id": serviceId, "day": day},
      ),
      onSuccess: (result) {
        final Map<String, dynamic> jsonData =
            result.data as Map<String, dynamic>;
        return TimeSlotsResponse.fromJson(jsonData);
      },
    );
  }
}
