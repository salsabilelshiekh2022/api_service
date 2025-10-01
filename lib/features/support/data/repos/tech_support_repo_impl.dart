import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/database/network/app_consumer.dart';
import '../../../../core/database/network/end_points.dart';
import '../../../../core/database/network/failure.dart';
import '../models/ticket_messages_model.dart';
import '../models/tickets_model.dart';
import 'tech_support_repo.dart';

class TechSupportRepoImpl implements TechSupportRepo {
  final ApiConsumer apiConsumer;

  TechSupportRepoImpl({required this.apiConsumer});
  @override
  Future<Either<Failure, int>> createNewTicket({required String title}) async {
    try {
      final result = await apiConsumer.post(
        path: EndPoints.createNewTicket,
        data: {"subject": title},
      );
      return Right(result['data']['id']);
    } on SocketException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, TicketsModel>> getTicketsList({int page = 1}) async {
    try {
      final result = await apiConsumer.get(
        EndPoints.getTickets,
        queryParameters: {'page': page},
      );
      return Right(TicketsModel.fromJson(result.data));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } on SocketException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> addMessageForTicket({
    required String message,
    required int id,
  }) async {
    try {
      await apiConsumer.post(
        path: EndPoints.addMessageForTicket(id: id),
        data: {"content": message},
      );
      return const Right("");
    } on SocketException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, TicketMessages>> showTicket({required int id}) async {
    try {
      final result = await apiConsumer.get(EndPoints.showATicket(id: id));
      return Right(TicketMessages.fromJson(result.data));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } on SocketException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
