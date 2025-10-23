import 'package:elmohtaref/core/di/dependency_injection.dart';
import 'package:elmohtaref/features/home/home/presentation/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../home/home/data/repos/home_repo.dart';
import '../cubit/bottom_sheet_cubit.dart';
import 'custom_nav_bar.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({
    super.key,
  });

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Status bar background color
      statusBarIconBrightness: Brightness.light, // Light icons
      statusBarBrightness: Brightness.light, // For iOS
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => MainNavigationCubit()),
        BlocProvider(
          create: (context) => HomeCubit(
            getIt<HomeRepo>(),
          )
            ..getHomeBanners()
            ..getHomeServices()
            ..getSocialMedia(),
        ),
      ],
      child: Scaffold(
        backgroundColor: appColors.homeBackgroundColor,
        body: BlocBuilder<MainNavigationCubit, MainNavigationState>(
          builder: (context, state) {
            return state.views[state.currentIndex];
          },
        ),
        bottomNavigationBar: const CustomNavBar(),
      ),
    );
  }
}
