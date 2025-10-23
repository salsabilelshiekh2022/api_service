import 'package:equatable/equatable.dart';

import '../data/models/visit_model.dart';

// The Visit model must be imported in the parent file (visits_cubit.dart)

enum VisitsStatus {
  initial,
  loading,
  success,
  failure,
  loadingMore,
  refreshing,
  searching,
  rateVisitLoading,
  rateVisitSuccess,
  rateVisitFailure,
}

// ignore: must_be_immutable
class VisitsState extends Equatable {
  final List<Visit> visits;
  final VisitsStatus status;
  final String? errorMessage;
  final String? successMessage;
  final bool hasReachedMax;
  final int currentPage;
  final String searchTerm;
  int? serviceId;
  String? fromDate;
  String? toDate;
  int? carTypeId;

  VisitsState({
    this.visits = const [],
    this.status = VisitsStatus.initial,
    this.errorMessage,
    this.hasReachedMax = false,
    this.currentPage = 1,
    this.successMessage,
    this.searchTerm = '',
    this.serviceId,
    this.fromDate,
    this.toDate,
    this.carTypeId,
  });

  VisitsState copyWith({
    List<Visit>? visits,
    VisitsStatus? status,
    String? errorMessage,
    bool? hasReachedMax,
    int? currentPage,
    String? searchTerm,
    String? successMessage,
    int? serviceId,
    String? fromDate,
    String? toDate,
    int? carModelId,
  }) {
    return VisitsState(
      visits: visits ?? this.visits,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      currentPage: currentPage ?? this.currentPage,
      searchTerm: searchTerm ?? this.searchTerm,
      successMessage: successMessage ?? this.successMessage,
      serviceId: serviceId ?? this.serviceId,
      fromDate: fromDate ?? this.fromDate,
      toDate: toDate ?? this.toDate,
      carTypeId: carModelId ?? carTypeId,
    );
  }

  @override
  List<Object?> get props => [
        visits,
        status,
        errorMessage,
        hasReachedMax,
        currentPage,
        searchTerm,
        successMessage,
        serviceId,
        fromDate,
        toDate,
        carTypeId
      ];

  bool get isInitial => status == VisitsStatus.initial;
  bool get isLoading => status == VisitsStatus.loading;
  bool get isLoadingMore => status == VisitsStatus.loadingMore;
  bool get isSuccess => status == VisitsStatus.success;
  bool get isFailure => status == VisitsStatus.failure;
  bool get isRefreshing => status == VisitsStatus.refreshing;
  bool get isSearching => status == VisitsStatus.searching;
  bool get isRateVisitLoading => status == VisitsStatus.rateVisitLoading;
  bool get isRateVisitSuccess => status == VisitsStatus.rateVisitSuccess;
  bool get isRateVisitFailure => status == VisitsStatus.rateVisitFailure;
  bool get isEmpty => isSuccess && visits.isEmpty;
  bool get isNotEmpty => isSuccess && visits.isNotEmpty;
}
