import 'package:dartz/dartz.dart';
import 'package:elmohtaref/features/reports/data/models/reports_model.dart';

import '../../../../core/database/network/failure.dart';

abstract class ReportsRepo {
  Future<Either<Failure, ReportsResponse>> getReports(
      {int page = 1,
      String? search,
      String? fromDate,
      String? toDate,
      int? carTypeId,
      int? serviceId});
}
