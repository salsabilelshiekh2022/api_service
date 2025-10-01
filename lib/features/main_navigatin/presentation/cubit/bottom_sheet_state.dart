part of 'bottom_sheet_cubit.dart';

class MainNavigationState extends Equatable {
  final List<Widget> views;
  final int currentIndex;

  const MainNavigationState({required this.views, required this.currentIndex});

  factory MainNavigationState.initial() {
    return const MainNavigationState(
      views: [
        HomeView(),
        ReportsView(),
        VisitsView(),
        SettingView(),
      ],
      currentIndex: 0,
    );
  }

  MainNavigationState copyWith({
    int? currentIndex,
  }) {
    return MainNavigationState(
      views: views,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }

  @override
  List<Object?> get props => [
        views,
        currentIndex,
      ];
}
