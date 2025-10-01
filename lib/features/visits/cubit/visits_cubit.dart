import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/models/rate_request_model.dart';
import '../data/models/visit_model.dart';
import '../data/repos/visits_repo.dart';
import 'visits_state.dart';

class VisitsCubit extends Cubit<VisitsState> {
  final VisitsRepo visitsRepo;
  VisitsCubit(this.visitsRepo) : super(VisitsState());

  Future<void> fetchVisits({String search = ''}) async {
    emit(state.copyWith(
        status: search.isEmpty ? VisitsStatus.loading : VisitsStatus.searching,
        searchTerm: search));
    final result = await visitsRepo.getVisits(
        page: 1,
        search: search,
        carTypeId: state.carTypeId,
        serviceId: state.serviceId,
        fromDate: state.fromDate,
        toDate: state.toDate);
    result.fold(
      (failure) => emit(state.copyWith(
          status: VisitsStatus.failure, errorMessage: failure.message)),
      (response) {
        final hasReachedMax = _checkIfReachedMax(response);
        emit(state.copyWith(
          status: VisitsStatus.success,
          visits: response.data,
          currentPage: 1,
          hasReachedMax: hasReachedMax,
        ));
      },
    );
  }

  Future<void> loadMore() async {
    emit(state.copyWith(status: VisitsStatus.loadingMore));
    final nextPage = state.currentPage + 1;
    final result =
        await visitsRepo.getVisits(page: nextPage, search: state.searchTerm);
    result.fold(
      (failure) => emit(state.copyWith(
          status: VisitsStatus.failure, errorMessage: failure.message)),
      (response) {
        final newVisits = response.data;
        final updatedList = List<Visit>.from(state.visits)..addAll(newVisits);
        final hasReachedMax = _checkIfReachedMax(response) || newVisits.isEmpty;
        emit(state.copyWith(
          status: VisitsStatus.success,
          visits: updatedList,
          currentPage: nextPage,
          hasReachedMax: hasReachedMax,
        ));
      },
    );
  }

  void onScrollEnd() {
    if (!state.hasReachedMax && state.status != VisitsStatus.loadingMore) {
      loadMore();
    }
  }

  Future<void> refreshVisits() async {
    emit(state.copyWith(status: VisitsStatus.refreshing));
    await fetchVisits(search: state.searchTerm);
  }

  bool _checkIfReachedMax(VisitsResponse response) {
    final currentPage = response.meta.currentPage;
    final lastPage = response.meta.lastPage;
    return currentPage >= lastPage;
  }

  Future<void> rateVisit(
      {required RateRequestModel rateRequestModel,
      required int visitId}) async {
    emit(state.copyWith(status: VisitsStatus.rateVisitLoading));
    final result = await visitsRepo.rateVisit(
        rateRequestModel: rateRequestModel, visitId: visitId);
    result.fold(
      (failure) => emit(state.copyWith(
          status: VisitsStatus.rateVisitFailure,
          errorMessage: failure.message)),
      (message) => emit(state.copyWith(
          status: VisitsStatus.rateVisitSuccess, successMessage: message)),
    );
  }
}
