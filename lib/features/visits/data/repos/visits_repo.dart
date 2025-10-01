import 'package:dartz/dartz.dart';
import 'package:elmohtaref/core/database/network/failure.dart';
import 'package:elmohtaref/features/visits/data/models/visit_enum_status.dart';
import 'package:elmohtaref/features/visits/data/models/visit_model.dart';

abstract class VisitsRepo {
  Future<Either<Failure, VisitsResponse>> getVisits(
      {int page = 1,
      String? search,
      int? serviceId,
      String? fromDate,
      String? toDate,
      int? carTypeId,
      VisitEnumStatus? status});
  Future<Either<Failure, String>> rateVisit(
      {required rateRequestModel, required int visitId});
}
