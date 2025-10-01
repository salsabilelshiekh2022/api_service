part of 'service_details_cubit.dart';

enum ServiceDetailsStateStatus {
  initial,
  loading,
  success,
  failure,
}

class ServiceDetailsState extends Equatable {
  final ServiceDetailsStateStatus status;
  final ServiceDetailResponse? serviceDetailsResponse;
  final Failure? failure;

  const ServiceDetailsState({
    required this.status,
    this.serviceDetailsResponse,
    this.failure,
  });

  ServiceDetailsState copyWith({
    ServiceDetailsStateStatus? status,
    ServiceDetailResponse? serviceDetailsResponse,
    Failure? failure,
  }) {
    return ServiceDetailsState(
      status: status ?? this.status,
      serviceDetailsResponse:
          serviceDetailsResponse ?? this.serviceDetailsResponse,
      failure: failure ?? this.failure,
    );
  }

  @override
  List<Object?> get props => [status, serviceDetailsResponse, failure];
}
