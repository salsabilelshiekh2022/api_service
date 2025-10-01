import 'package:elmohtaref/features/reports/data/models/reports_model.dart';
import 'package:elmohtaref/features/reports/data/repos/reports_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;

import 'reports_state.dart';

class ReportsCubit extends Cubit<ReportsState> {
  ReportsCubit(this.reportsRepo) : super(ReportsState());
  final ReportsRepo reportsRepo;

  Future<void> fetchReports({String search = ''}) async {
    emit(state.copyWith(
        status:
            search.isEmpty ? ReportsStatus.loading : ReportsStatus.searching,
        searchTerm: search));
    final result = await reportsRepo.getReports(
        page: 1,
        search: search,
        fromDate: state.fromDate,
        toDate: state.toDate,
        carTypeId: state.carModelId,
        serviceId: state.serviceId);
    result.fold(
      (failure) => emit(state.copyWith(
          status: ReportsStatus.failure, errorMessage: failure.message)),
      (response) {
        final hasReachedMax = _checkIfReachedMax(response);
        emit(state.copyWith(
          status: ReportsStatus.success,
          reports: response.data,
          currentPage: 1,
          hasReachedMax: hasReachedMax,
        ));
      },
    );
  }

  Future<void> loadMore() async {
    emit(state.copyWith(status: ReportsStatus.loadingMore));
    final nextPage = state.currentPage + 1;
    final result =
        await reportsRepo.getReports(page: nextPage, search: state.searchTerm);
    result.fold(
      (failure) => emit(state.copyWith(
          status: ReportsStatus.failure, errorMessage: failure.message)),
      (response) {
        final newVisits = response.data;
        final updatedList = List<Report>.from(state.reports)..addAll(newVisits);
        final hasReachedMax = _checkIfReachedMax(response) || newVisits.isEmpty;
        emit(state.copyWith(
          status: ReportsStatus.success,
          reports: updatedList,
          currentPage: nextPage,
          hasReachedMax: hasReachedMax,
        ));
      },
    );
  }

  void onScrollEnd() {
    if (!state.hasReachedMax && state.status != ReportsStatus.loadingMore) {
      loadMore();
    }
  }

  Future<void> refreshVisits() async {
    emit(state.copyWith(status: ReportsStatus.refreshing));
    await fetchReports(search: state.searchTerm);
  }

  bool _checkIfReachedMax(ReportsResponse response) {
    final currentPage = response.meta.currentPage;
    final lastPage = response.meta.lastPage;
    return currentPage >= lastPage;
  }
}
