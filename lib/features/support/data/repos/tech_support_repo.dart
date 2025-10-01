import 'package:dartz/dartz.dart';

import '../../../../core/database/network/failure.dart';
import '../models/ticket_messages_model.dart';
import '../models/tickets_model.dart';

abstract class TechSupportRepo {
  Future<Either<Failure, int>> createNewTicket({required String title});
  Future<Either<Failure, TicketsModel>> getTicketsList({int page = 1});
  Future<Either<Failure, String>> addMessageForTicket({
    required String message,
    required int id,
  });
  Future<Either<Failure, TicketMessages>> showTicket({required int id});
}
