import 'package:equatable/equatable.dart';

import '../../../../core/database/network/failure.dart';
import '../../data/models/ticket_messages_model.dart';
import '../../data/models/tickets_model.dart';

enum TechSupportStatus {
  initial,
  createTicketLoading,
  createTicketSuccess,
  createTicketFailure,
  getTicketsListLoading,
  getTicketsListLoadingMore, // Added for pagination
  getTicketsListRefreshing, // Added for pull to refresh
  getTicketsListSuccess,
  getTicketsListFailure,
  addMessageLoading,
  addMessageSuccess,
  addMessageFailure,
  getMessagesLoading,
  getMessagesSuccess,
  getMessagesFailure,
}

extension TechSupportStateX on TechSupportState {
  bool get isInitial => status == TechSupportStatus.initial;
  bool get isCreateTicketLoading =>
      status == TechSupportStatus.createTicketLoading;
  bool get isCreateTicketSuccess =>
      status == TechSupportStatus.createTicketSuccess;
  bool get isCreateTicketFailure =>
      status == TechSupportStatus.createTicketFailure;
  bool get isGetTicketsListLoading =>
      status == TechSupportStatus.getTicketsListLoading;
  bool get isGetTicketsListLoadingMore =>
      status == TechSupportStatus.getTicketsListLoadingMore;
  bool get isGetTicketsListRefreshing =>
      status == TechSupportStatus.getTicketsListRefreshing;
  bool get isGetTicketsListSuccess =>
      status == TechSupportStatus.getTicketsListSuccess;
  bool get isGetTicketsListFailure =>
      status == TechSupportStatus.getTicketsListFailure;
  bool get isAddMessageLoading => status == TechSupportStatus.addMessageLoading;
  bool get isAddMessageSuccess => status == TechSupportStatus.addMessageSuccess;
  bool get isAddMessageFailure => status == TechSupportStatus.addMessageFailure;
  bool get isGetMessagesLoading =>
      status == TechSupportStatus.getMessagesLoading;
  bool get isGetMessagesSuccess =>
      status == TechSupportStatus.getMessagesSuccess;
  bool get isGetMessagesFailure =>
      status == TechSupportStatus.getMessagesFailure;

  // Helper getters for loading states
  bool get isAnyLoading =>
      isCreateTicketLoading ||
      isGetTicketsListLoading ||
      isGetTicketsListLoadingMore ||
      isGetTicketsListRefreshing ||
      isAddMessageLoading ||
      isGetMessagesLoading;

  // Helper getters for failure states
  bool get isAnyFailure =>
      isCreateTicketFailure ||
      isGetTicketsListFailure ||
      isAddMessageFailure ||
      isGetMessagesFailure;

  // Helper getters for empty states
  bool get isEmpty => isGetTicketsListSuccess && ticketsList.isEmpty;
  bool get isNotEmpty => isGetTicketsListSuccess && ticketsList.isNotEmpty;
}

// Updated TechSupportState class
// ignore: must_be_immutable
class TechSupportState extends Equatable {
  final TechSupportStatus status;
  final String? message;
  final int? ticketId;
  final TicketsModel? ticketsModel;
  final TicketMessages? ticketMessages;
  final Failure? failure;
  final List<Ticket> ticketsList;
  List<Messages> messages;
  final bool hasReachedMax; // Added for pagination
  final int currentPage; // Added for pagination

  TechSupportState({
    required this.status,
    this.message,
    this.ticketId,
    this.ticketsModel,
    this.ticketMessages,
    this.failure,
    this.ticketsList = const [],
    this.messages = const [],
    this.hasReachedMax = false,
    this.currentPage = 1,
  });

  factory TechSupportState.initial() =>
      TechSupportState(status: TechSupportStatus.initial);

  TechSupportState copyWith({
    TechSupportStatus? status,
    String? message,
    int? ticketId,
    TicketsModel? ticketsModel,
    TicketMessages? ticketMessages,
    Failure? failure,
    List<Ticket>? ticketsList,
    List<Messages>? messages,
    bool? hasReachedMax,
    int? currentPage,
  }) {
    return TechSupportState(
      status: status ?? this.status,
      message: message ?? this.message,
      ticketId: ticketId ?? this.ticketId,
      ticketsModel: ticketsModel ?? this.ticketsModel,
      ticketMessages: ticketMessages ?? this.ticketMessages,
      failure: failure ?? this.failure,
      ticketsList: ticketsList ?? this.ticketsList,
      messages: messages ?? this.messages,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  // Convenience getters
  int get totalTickets => ticketsModel?.meta?.total ?? 0;

  @override
  List<Object?> get props => [
        status,
        message,
        ticketId,
        ticketsModel,
        ticketMessages,
        failure,
        ticketsList,
        messages,
        hasReachedMax,
        currentPage,
      ];
}
