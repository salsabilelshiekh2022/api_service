import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/database/network/api_consumer.dart';
import '../../../../core/database/network/end_points.dart';
import '../../../../core/database/network/failure.dart';
import '../models/ticket_messages_model.dart';
import '../models/tickets_model.dart';
import 'tech_support_repo.dart';

@LazySingleton(as: TechSupportRepo)
class TechSupportRepoImpl implements TechSupportRepo {
  final ApiConsumer apiConsumer;

  TechSupportRepoImpl({required this.apiConsumer});

  @override
  Future<Either<Failure, int>> createNewTicket({
    required String title,
  }) async {
    return apiConsumer.handleRequest(
      request: () => apiConsumer.post(
        path: EndPoints.createNewTicket,
        data: {"subject": title},
      ),
      onSuccess: (result) => result['data']['id'] as int,
    );
  }

  @override
  Future<Either<Failure, TicketsModel>> getTicketsList({
    int page = 1,
  }) async {
    return apiConsumer.handleRequest(
      request: () => apiConsumer.get(
        EndPoints.getTickets,
        queryParameters: {'page': page},
      ),
      onSuccess: (result) => TicketsModel.fromJson(result.data),
    );
  }

  @override
  Future<Either<Failure, String>> addMessageForTicket({
    required String message,
    required int id,
  }) async {
    return apiConsumer.handleRequest(
      request: () => apiConsumer.post(
        path: EndPoints.addMessageForTicket(id: id),
        data: {"content": message},
      ),
      onSuccess: (_) => "",
    );
  }

  @override
  Future<Either<Failure, TicketMessages>> showTicket({
    required int id,
  }) async {
    return apiConsumer.handleRequest(
      request: () => apiConsumer.get(EndPoints.showATicket(id: id)),
      onSuccess: (result) => TicketMessages.fromJson(result.data),
    );
  }
}
