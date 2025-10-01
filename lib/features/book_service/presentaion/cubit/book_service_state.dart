part of 'book_service_cubit.dart';

enum BookServiceStatus {
  initial,
  loading,
  success,
  failure,
  getCarTypesLoading,
  getCarTypesSuccess,
  getCarTypesFailure,
  getCarModelsLoading,
  getCarModelsSuccess,
  getCarModelsFailure,
  getTimeAvalabilityLoading,
  getTimeAvalabilityFailure,
  getTimeAvalabiltySuccess,
}

class BookServiceState extends Equatable {
  final BookServiceStatus status;
  final String? message;
  final String? errorMessage;
  final Failure? failure;
  final CarTypesResponse? carTypesResponse;
  final CarTypesResponse? carModelsResponse;
  final TimeSlotsResponse? timeSlotsResponse;

  const BookServiceState({
    this.status = BookServiceStatus.initial,
    this.message,
    this.errorMessage,
    this.failure,
    this.carTypesResponse,
    this.carModelsResponse,
    this.timeSlotsResponse,
  });

  BookServiceState copyWith({
    BookServiceStatus? status,
    String? message,
    String? errorMessage,
    Failure? failure,
    CarTypesResponse? carTypesResponse,
    CarTypesResponse? carModelsResponse,
    TimeSlotsResponse? timeSlotsResponse,
  }) {
    return BookServiceState(
      status: status ?? this.status,
      message: message ?? this.message,
      errorMessage: errorMessage ?? this.errorMessage,
      failure: failure ?? this.failure,
      carTypesResponse: carTypesResponse ?? this.carTypesResponse,
      carModelsResponse: carModelsResponse ?? this.carModelsResponse,
      timeSlotsResponse: timeSlotsResponse ?? this.timeSlotsResponse,
    );
  }

  @override
  List<Object?> get props => [
        status,
        message,
        errorMessage,
        failure,
        carTypesResponse,
        carModelsResponse,
        timeSlotsResponse,
      ];

  // Convenience getters for status checking
  bool get isInitial => status == BookServiceStatus.initial;
  bool get isLoading => status == BookServiceStatus.loading;
  bool get isSuccess => status == BookServiceStatus.success;
  bool get isFailure => status == BookServiceStatus.failure;

  // Car Types specific getters
  bool get isGetCarTypesLoading =>
      status == BookServiceStatus.getCarTypesLoading;
  bool get isGetCarTypesSuccess =>
      status == BookServiceStatus.getCarTypesSuccess;
  bool get isGetCarTypesFailure =>
      status == BookServiceStatus.getCarTypesFailure;

  // Car Models specific getters
  bool get isGetCarModelsLoading =>
      status == BookServiceStatus.getCarModelsLoading;
  bool get isGetCarModelsSuccess =>
      status == BookServiceStatus.getCarModelsSuccess;
  bool get isGetCarModelsFailure =>
      status == BookServiceStatus.getCarModelsFailure;

  // Time slots specific getters

  bool get isGetTimeAvalibiltyLoading =>
      status == BookServiceStatus.getTimeAvalabilityLoading;
  bool get isGetTimeAvalibiltySuccess =>
      status == BookServiceStatus.getTimeAvalabiltySuccess;
  bool get isGetTimeAvalibiltyFailure =>
      status == BookServiceStatus.getTimeAvalabilityFailure;

  // Additional convenience getters
  bool get hasCarTypes => carTypesResponse != null;
  bool get hasCarModels => carModelsResponse != null;
  bool get hasTimeAvalabilty => timeSlotsResponse != null;
  bool get hasError => failure != null || errorMessage != null;
}
