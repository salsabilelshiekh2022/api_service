import 'package:elmohtaref/features/reports/presentation/views/reports_view.dart';
import 'package:elmohtaref/features/visits/presentation/views/visits_view.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../home/home/presentation/views/home_view.dart';
import '../../../setting/presentation/views/setting_view.dart';

part 'bottom_sheet_state.dart';

class MainNavigationCubit extends Cubit<MainNavigationState> {
  MainNavigationCubit() : super(MainNavigationState.initial());

  void changeIndex(int index) {
    emit(
      state.copyWith(
        currentIndex: index,
      ),
    );
  }
}
