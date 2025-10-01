import 'package:elmohtaref/features/service_details/data/repos/service_details_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/database/network/failure.dart';
import '../../data/service_details_model.dart';

part 'service_details_state.dart';

class ServiceDetailsCubit extends Cubit<ServiceDetailsState> {
  ServiceDetailsCubit(this._serviceDetailsRepo)
      : super(ServiceDetailsState(status: ServiceDetailsStateStatus.initial));

  final ServiceDetailsRepo _serviceDetailsRepo;

  Future<void> getServiceDetails({required int id}) async {
    emit(state.copyWith(status: ServiceDetailsStateStatus.loading));
    final failureOrServiceDetails =
        await _serviceDetailsRepo.getServiceDetails(id: id);
    failureOrServiceDetails.fold(
      (failure) => emit(
        state.copyWith(
          failure: failure,
          status: ServiceDetailsStateStatus.failure,
        ),
      ),
      (serviceDetails) => emit(
        state.copyWith(
          serviceDetailsResponse: serviceDetails,
          status: ServiceDetailsStateStatus.success,
        ),
      ),
    );
  }
}
