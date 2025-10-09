import 'package:dartz/dartz.dart';
import 'package:elmohtaref/core/database/network/failure.dart';
import 'package:elmohtaref/features/reports/data/models/reports_model.dart';
import 'package:elmohtaref/features/reports/data/repos/reports_repo.dart';
import '../../../../core/database/network/api_consumer.dart';
import '../../../../core/database/network/end_points.dart';

class ReportsRepoImpl implements ReportsRepo {
  final ApiConsumer apiConsumer;

  ReportsRepoImpl({required this.apiConsumer});

  @override
  Future<Either<Failure, ReportsResponse>> getReports({
    int page = 1,
    String? search,
    String? fromDate,
    String? toDate,
    int? carTypeId,
    int? serviceId,
  }) async {
    return apiConsumer.handleRequest(
      request: () => apiConsumer.get(
        EndPoints.reports,
        queryParameters: {
          'page': page,
          'search': search,
          'date_from': fromDate,
          'date_to': toDate,
          'car_type_id': carTypeId,
          'service_id': serviceId,
        },
      ),
      onSuccess: (result) {
        final Map<String, dynamic> jsonData =
            result.data as Map<String, dynamic>;
        return ReportsResponse.fromJson(jsonData);
      },
    );
  }
}
