import 'package:dartz/dartz.dart';
import 'package:elmohtaref/features/book_service/data/models/car_type_model.dart';
import 'package:elmohtaref/features/book_service/data/models/time_slots_model.dart';

import '../../../../core/database/network/failure.dart';
import '../models/book_service_request_model.dart';

abstract class BookServiceRepo {
  Future<Either<Failure, String>> bookService(
      {required BookServiceRequestModel bookServiceModel});

  Future<Either<Failure, CarTypesResponse>> getCarTypes();
  Future<Either<Failure, CarTypesResponse>> getCarModels({required int id});
  Future<Either<Failure, TimeSlotsResponse>> getTimeAvilability(
      {required int serviceId, String? day});
}
