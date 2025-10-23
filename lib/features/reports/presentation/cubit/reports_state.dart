import 'package:elmohtaref/features/reports/data/models/reports_model.dart';
import 'package:equatable/equatable.dart';

// The Visit model must be imported in the parent file (visits_cubit.dart)

enum ReportsStatus {
  initial,
  loading,
  success,
  failure,
  loadingMore,
  refreshing,
  searching
}

// ignore: must_be_immutable
class ReportsState extends Equatable {
  final List<Report> reports;
  final ReportsStatus status;
  final String? errorMessage;
  final bool hasReachedMax;
  final int currentPage;
  final String searchTerm;
  int? serviceId;
  String? fromDate;
  String? toDate;
  int? carModelId;

  ReportsState({
    this.reports = const [],
    this.status = ReportsStatus.initial,
    this.errorMessage,
    this.hasReachedMax = false,
    this.currentPage = 1,
    this.searchTerm = '',
    this.serviceId,
    this.fromDate,
    this.toDate,
    this.carModelId,
  });

  ReportsState copyWith({
    List<Report>? reports,
    ReportsStatus? status,
    String? errorMessage,
    bool? hasReachedMax,
    int? currentPage,
    String? searchTerm,
    int? serviceId,
    String? fromDate,
    String? toDate,
    int? carModelId,
  }) {
    return ReportsState(
      reports: reports ?? this.reports,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      currentPage: currentPage ?? this.currentPage,
      searchTerm: searchTerm ?? this.searchTerm,
      serviceId: serviceId ?? this.serviceId,
      fromDate: fromDate ?? this.fromDate,
      toDate: toDate ?? this.toDate,
      carModelId: carModelId ?? this.carModelId,
    );
  }

  @override
  List<Object?> get props => [
        reports,
        status,
        errorMessage,
        hasReachedMax,
        currentPage,
        searchTerm,
        serviceId,
        fromDate,
        toDate,
        carModelId
      ];

  bool get isInitial => status == ReportsStatus.initial;
  bool get isLoading => status == ReportsStatus.loading;
  bool get isLoadingMore => status == ReportsStatus.loadingMore;
  bool get isSuccess => status == ReportsStatus.success;
  bool get isFailure => status == ReportsStatus.failure;
  bool get isRefreshing => status == ReportsStatus.refreshing;

  bool get isEmpty => isSuccess && reports.isEmpty;
  bool get isNotEmpty => isSuccess && reports.isNotEmpty;
}
