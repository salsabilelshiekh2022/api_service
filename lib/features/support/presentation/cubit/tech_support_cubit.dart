import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/ticket_messages_model.dart';
import '../../data/models/tickets_model.dart';
import '../../data/repos/tech_support_repo.dart';
import 'tech_support_state.dart';

class TechSupportCubit extends Cubit<TechSupportState> {
  TechSupportCubit(this.techSupportRepo) : super(TechSupportState.initial());
  final TechSupportRepo techSupportRepo;

  Future<void> createNewTicket({required String title}) async {
    emit(state.copyWith(status: TechSupportStatus.createTicketLoading));
    final result = await techSupportRepo.createNewTicket(title: title);
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: TechSupportStatus.createTicketFailure,
            failure: failure,
          ),
        );
      },
      (id) {
        emit(
          state.copyWith(
            status: TechSupportStatus.createTicketSuccess,
            message: "",
            ticketId: id,
          ),
        );
      },
    );
  }

  // Updated getTicketsList with pagination
  Future<void> getTicketsList() async {
    emit(state.copyWith(status: TechSupportStatus.getTicketsListLoading));
    final result = await techSupportRepo.getTicketsList(page: 1);
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: TechSupportStatus.getTicketsListFailure,
            failure: failure,
          ),
        );
      },
      (ticketsModel) {
        final hasReachedMax = _checkIfReachedMax(ticketsModel);
        emit(
          state.copyWith(
            status: TechSupportStatus.getTicketsListSuccess,
            ticketsModel: ticketsModel,
            ticketsList: ticketsModel.tickets ?? [],
            currentPage: 1,
            hasReachedMax: hasReachedMax,
          ),
        );
      },
    );
  }

  // Added loadMoreTickets method
  Future<void> loadMoreTickets() async {
    if (state.hasReachedMax || state.isGetTicketsListLoadingMore) return;

    emit(state.copyWith(status: TechSupportStatus.getTicketsListLoadingMore));

    final nextPage = state.currentPage + 1;
    final result = await techSupportRepo.getTicketsList(page: nextPage);

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: TechSupportStatus.getTicketsListFailure,
          failure: failure,
        ),
      ),
      (ticketsModel) {
        final newTickets = ticketsModel.tickets ?? [];
        final updatedList = List<Ticket>.from(state.ticketsList)
          ..addAll(newTickets);

        final hasReachedMax =
            _checkIfReachedMax(ticketsModel) || newTickets.isEmpty;

        emit(
          state.copyWith(
            status: TechSupportStatus.getTicketsListSuccess,
            ticketsModel: ticketsModel,
            ticketsList: updatedList,
            currentPage: nextPage,
            hasReachedMax: hasReachedMax,
          ),
        );
      },
    );
  }

  // Added refreshTickets method
  Future<void> refreshTickets() async {
    emit(state.copyWith(status: TechSupportStatus.getTicketsListRefreshing));

    final result = await techSupportRepo.getTicketsList(page: 1);
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: TechSupportStatus.getTicketsListFailure,
          failure: failure,
        ),
      ),
      (ticketsModel) {
        final hasReachedMax = _checkIfReachedMax(ticketsModel);
        emit(
          state.copyWith(
            status: TechSupportStatus.getTicketsListSuccess,
            ticketsModel: ticketsModel,
            ticketsList: ticketsModel.tickets ?? [],
            currentPage: 1,
            hasReachedMax: hasReachedMax,
          ),
        );
      },
    );
  }

  // Helper method to check if reached max pages
  bool _checkIfReachedMax(TicketsModel ticketsModel) {
    if (ticketsModel.meta == null) return true;

    final currentPage = ticketsModel.meta!.currentPage ?? 1;
    final lastPage = ticketsModel.meta!.lastPage ?? 1;

    return currentPage >= lastPage;
  }

  Future<void> addMessageForTicket({
    required String message,
    required int id,
  }) async {
    List<Messages> myMessages = state.messages;
    myMessages.add(Messages(id: -1, sender: "User", content: message));
    emit(
      state.copyWith(
        status: TechSupportStatus.addMessageLoading,
        messages: myMessages,
      ),
    );
    final result = await techSupportRepo.addMessageForTicket(
      message: message,
      id: id,
    );
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: TechSupportStatus.addMessageFailure,
            failure: failure,
          ),
        );
      },
      (string) {
        emit(state.copyWith(status: TechSupportStatus.addMessageSuccess));
      },
    );
  }

  Future<void> showTicket({required int id}) async {
    emit(state.copyWith(status: TechSupportStatus.getMessagesLoading));
    final result = await techSupportRepo.showTicket(id: id);
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: TechSupportStatus.getMessagesFailure,
            failure: failure,
          ),
        );
      },
      (ticketMessages) {
        emit(
          state.copyWith(
            status: TechSupportStatus.getMessagesSuccess,
            ticketMessages: ticketMessages,
            messages: ticketMessages.data!.messages ?? [],
          ),
        );
      },
    );
  }
}
